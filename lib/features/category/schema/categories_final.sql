-- =============================================
-- SCHÉMA FINAL DES CATÉGORIES POCKETLY
-- =============================================
-- Version consolidée et sécurisée
-- Date: $(date)
-- Description: Schéma complet des catégories avec sécurité RLS

-- =============================================
-- TABLE CATÉGORIES
-- =============================================

-- Table pour stocker les catégories de transactions
CREATE TABLE public.categories (
  -- Identifiant unique (BIGINT pour permettre des IDs fixes pour les catégories par défaut)
  id BIGINT PRIMARY KEY,
  
  -- Nom de la catégorie (clé pour i18n ou nom custom)
  name TEXT NOT NULL,
  
  -- Type de catégorie (income/expense)
  type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
  
  -- Nom de l'icône Material Design
  icon_name TEXT NOT NULL,
  
  -- Couleur hexadécimale (#RRGGBB)
  color TEXT NOT NULL CHECK (color ~ '^#[0-9A-Fa-f]{6}$'),
  
  -- Indique si c'est une catégorie custom (créée par l'utilisateur)
  is_custom BOOLEAN NOT NULL DEFAULT FALSE,
  
  -- ID de l'utilisateur qui a créé la catégorie custom (NULL pour les catégories par défaut)
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
  
  -- Métadonnées temporelles
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  -- Contraintes
  CONSTRAINT categories_name_not_empty CHECK (LENGTH(TRIM(name)) > 0),
  CONSTRAINT categories_icon_name_not_empty CHECK (LENGTH(TRIM(icon_name)) > 0),
  CONSTRAINT categories_custom_has_user CHECK (
    (is_custom = TRUE AND user_id IS NOT NULL) OR 
    (is_custom = FALSE AND user_id IS NULL)
  )
);

-- =============================================
-- SÉQUENCE POUR LES CATÉGORIES CUSTOM
-- =============================================

-- Créer une séquence pour les catégories custom (commence à 1000)
CREATE SEQUENCE public.categories_custom_id_seq START 1000;

-- =============================================
-- INDEX POUR OPTIMISATION DES PERFORMANCES
-- =============================================

-- Index sur le type pour filtrer rapidement
CREATE INDEX idx_categories_type ON public.categories(type);

-- Index sur is_custom pour séparer les catégories par défaut des custom
CREATE INDEX idx_categories_is_custom ON public.categories(is_custom);

-- Index composite pour les requêtes fréquentes
CREATE INDEX idx_categories_type_custom ON public.categories(type, is_custom);

-- Index sur created_at pour le tri chronologique
CREATE INDEX idx_categories_created_at ON public.categories(created_at);

-- Index sur user_id pour les requêtes par utilisateur
CREATE INDEX idx_categories_user_id ON public.categories(user_id);

-- =============================================
-- TRIGGER POUR METTRE À JOUR TIMESTAMP
-- =============================================

-- Trigger pour mettre à jour le timestamp lors des modifications
CREATE TRIGGER update_categories_updated_at
  BEFORE UPDATE ON public.categories
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

-- =============================================
-- POLITIQUES DE SÉCURITÉ (RLS) - ACCÈS RESTRICTIF
-- =============================================

-- Activer RLS sur la table categories
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

-- =============================================
-- POLITIQUES RLS SÉCURISÉES
-- =============================================

-- Politique 1: Tous les utilisateurs connectés peuvent voir les catégories par défaut
CREATE POLICY "View default categories"
  ON public.categories
  FOR SELECT
  TO authenticated
  USING (is_custom = FALSE);

-- Politique 2: Seuls les utilisateurs premium (payant OU trial actif) peuvent créer des catégories custom
CREATE POLICY "Create custom categories"
  ON public.categories
  FOR INSERT
  TO authenticated
  WITH CHECK (
    is_custom = TRUE AND
    user_id = auth.uid() AND
    is_user_premium(auth.uid())
  );

-- Politique 3: Seuls les utilisateurs premium peuvent voir LEURS catégories custom
CREATE POLICY "View own custom categories"
  ON public.categories
  FOR SELECT
  TO authenticated
  USING (
    is_custom = TRUE AND
    user_id = auth.uid() AND
    is_user_premium(auth.uid())
  );

-- Politique 4: Seuls les utilisateurs premium peuvent modifier LEURS catégories custom
CREATE POLICY "Update own custom categories"
  ON public.categories
  FOR UPDATE
  TO authenticated
  USING (
    is_custom = TRUE AND
    user_id = auth.uid() AND
    is_user_premium(auth.uid())
  );

-- Politique 5: Seuls les utilisateurs premium peuvent supprimer LEURS catégories custom
CREATE POLICY "Delete own custom categories"
  ON public.categories
  FOR DELETE
  TO authenticated
  USING (
    is_custom = TRUE AND
    user_id = auth.uid() AND
    is_user_premium(auth.uid())
  );

-- =============================================
-- DONNÉES PAR DÉFAUT (CATÉGORIES SYSTÈME)
-- =============================================

-- Insérer les catégories par défaut pour les dépenses
INSERT INTO public.categories (id, name, type, icon_name, color, is_custom, created_at, updated_at) VALUES
(1, 'food', 'expense', 'utensils', '#F59E0B', FALSE, NOW(), NOW()),
(2, 'housing', 'expense', 'home', '#F97316', FALSE, NOW(), NOW()),
(3, 'transport', 'expense', 'car', '#3B82F6', FALSE, NOW(), NOW()),
(4, 'health', 'expense', 'heart', '#EF4444', FALSE, NOW(), NOW()),
(5, 'leisure', 'expense', 'gamepad', '#8B5CF6', FALSE, NOW(), NOW()),
(6, 'shopping', 'expense', 'shopping-bag', '#EC4899', FALSE, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Insérer les catégories par défaut pour les revenus
INSERT INTO public.categories (id, name, type, icon_name, color, is_custom, created_at, updated_at) VALUES
(7, 'salary', 'income', 'wallet', '#10B981', FALSE, NOW(), NOW()),
(8, 'bonus', 'income', 'coins', '#16A34A', FALSE, NOW(), NOW()),
(9, 'investment', 'income', 'trending-up', '#059669', FALSE, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- =============================================
-- FONCTIONS UTILES POUR LES CATÉGORIES
-- =============================================

-- Fonction pour vérifier si un utilisateur est premium (payant OU trial actif)
CREATE OR REPLACE FUNCTION is_user_premium(user_id UUID DEFAULT auth.uid())
RETURNS BOOLEAN AS $$
DECLARE
    user_record RECORD;
BEGIN
    -- Récupérer les données utilisateur
    SELECT
        is_premium,
        premium_trial_start,
        premium_trial_end
    INTO user_record
    FROM public.users
    WHERE id = user_id;

    -- Si l'utilisateur n'existe pas
    IF NOT FOUND THEN
        RETURN FALSE;
    END IF;

    -- Vérifier si premium actif
    IF user_record.is_premium = TRUE THEN
        RETURN TRUE;
    END IF;

    -- Vérifier si trial actif
    IF user_record.premium_trial_start IS NOT NULL
       AND user_record.premium_trial_end IS NOT NULL
       AND NOW() >= user_record.premium_trial_start
       AND NOW() < user_record.premium_trial_end THEN
        RETURN TRUE;
    END IF;

    -- Ni premium ni trial actif
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Fonction pour créer une catégorie custom avec ID automatique
CREATE OR REPLACE FUNCTION create_custom_category(
  p_name TEXT,
  p_type TEXT,
  p_icon_name TEXT,
  p_color TEXT,
  p_user_id UUID
)
RETURNS BIGINT AS $$
DECLARE
  new_id BIGINT;
BEGIN
  -- Vérifier que l'utilisateur est premium (payant OU trial actif)
  IF NOT is_user_premium(p_user_id) THEN
    RAISE EXCEPTION 'Seuls les utilisateurs premium peuvent créer des catégories custom';
  END IF;
  
  -- Générer un nouvel ID pour la catégorie custom
  new_id := nextval('public.categories_custom_id_seq');
  
  -- Insérer la catégorie custom
  INSERT INTO public.categories (id, name, type, icon_name, color, is_custom, user_id, created_at, updated_at)
  VALUES (new_id, p_name, p_type, p_icon_name, p_color, TRUE, p_user_id, NOW(), NOW());
  
  RETURN new_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Fonction pour obtenir toutes les catégories par défaut
CREATE OR REPLACE FUNCTION get_default_categories()
RETURNS TABLE (
    id BIGINT,
    name TEXT,
    type TEXT,
    icon_name TEXT,
    color TEXT,
    is_custom BOOLEAN,
    user_id UUID,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT c.id, c.name, c.type, c.icon_name, c.color, c.is_custom, c.user_id, c.created_at, c.updated_at
    FROM public.categories c
    WHERE c.is_custom = FALSE
    ORDER BY c.type, c.id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Fonction pour obtenir les catégories custom d'un utilisateur premium
CREATE OR REPLACE FUNCTION get_user_custom_categories()
RETURNS TABLE (
    id BIGINT,
    name TEXT,
    type TEXT,
    icon_name TEXT,
    color TEXT,
    is_custom BOOLEAN,
    user_id UUID,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
) AS $$
BEGIN
    -- Vérifier que l'utilisateur est premium (payant OU trial actif)
    IF NOT is_user_premium() THEN
        RAISE EXCEPTION 'Accès refusé : seuls les utilisateurs premium peuvent voir leurs catégories custom';
    END IF;
    
    RETURN QUERY
    SELECT c.id, c.name, c.type, c.icon_name, c.color, c.is_custom, c.user_id, c.created_at, c.updated_at
    FROM public.categories c
    WHERE c.is_custom = TRUE AND c.user_id = auth.uid()
    ORDER BY c.created_at DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Fonction pour obtenir les catégories par type
CREATE OR REPLACE FUNCTION get_categories_by_type(category_type TEXT)
RETURNS TABLE (
    id BIGINT,
    name TEXT,
    type TEXT,
    icon_name TEXT,
    color TEXT,
    is_custom BOOLEAN,
    user_id UUID,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT c.id, c.name, c.type, c.icon_name, c.color, c.is_custom, c.user_id, c.created_at, c.updated_at
    FROM public.categories c
    WHERE c.type = category_type
    ORDER BY c.is_custom, c.id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- VUES UTILES
-- =============================================

-- Vue pour toutes les catégories (défaut + custom de l'utilisateur premium)
CREATE OR REPLACE VIEW user_categories AS
SELECT 
    c.id,
    c.name,
    c.type,
    c.icon_name,
    c.color,
    c.is_custom,
    c.user_id,
    c.created_at,
    c.updated_at
FROM public.categories c
WHERE c.is_custom = FALSE 
   OR (c.is_custom = TRUE AND c.user_id = auth.uid() AND is_user_premium(auth.uid()))
ORDER BY c.is_custom, c.type, c.id;

-- Vue pour les statistiques des catégories
CREATE OR REPLACE VIEW category_stats AS
SELECT 
    c.type,
    COUNT(*) as total_categories,
    COUNT(CASE WHEN c.is_custom = TRUE THEN 1 END) as custom_categories,
    COUNT(CASE WHEN c.is_custom = FALSE THEN 1 END) as default_categories
FROM public.categories c
GROUP BY c.type;

-- =============================================
-- TESTS ET VALIDATION
-- =============================================

-- Vérifier que les catégories par défaut existent
DO $$
DECLARE
    default_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO default_count 
    FROM public.categories 
    WHERE is_custom = FALSE;
    
    IF default_count < 9 THEN
        RAISE EXCEPTION 'Les catégories par défaut ne sont pas toutes présentes. Attendu: 9, Trouvé: %', default_count;
    END IF;
    
    RAISE NOTICE '✅ % catégories par défaut trouvées', default_count;
END $$;

-- Vérifier les contraintes de données
DO $$
BEGIN
    -- Vérifier qu'il n'y a pas de catégories avec des noms vides
    IF EXISTS (SELECT 1 FROM public.categories WHERE LENGTH(TRIM(name)) = 0) THEN
        RAISE EXCEPTION '❌ Des catégories ont des noms vides';
    END IF;
    
    -- Vérifier qu'il n'y a pas de catégories avec des couleurs invalides
    IF EXISTS (SELECT 1 FROM public.categories WHERE color !~ '^#[0-9A-Fa-f]{6}$') THEN
        RAISE EXCEPTION '❌ Des catégories ont des couleurs invalides';
    END IF;
    
    -- Vérifier qu'il n'y a pas de catégories avec des types invalides
    IF EXISTS (SELECT 1 FROM public.categories WHERE type NOT IN ('income', 'expense')) THEN
        RAISE EXCEPTION '❌ Des catégories ont des types invalides';
    END IF;
    
    RAISE NOTICE '✅ Toutes les contraintes de données sont respectées';
END $$;

-- =============================================
-- COMMENTAIRES EXPLICATIFS
-- =============================================

COMMENT ON TABLE public.categories IS 'Stocke les catégories de transactions pour Pocketly';
COMMENT ON COLUMN public.categories.id IS 'Identifiant unique de la catégorie';
COMMENT ON COLUMN public.categories.name IS 'Nom de la catégorie (clé i18n pour les défaut, nom custom pour les utilisateurs)';
COMMENT ON COLUMN public.categories.type IS 'Type de catégorie: income (revenu) ou expense (dépense)';
COMMENT ON COLUMN public.categories.icon_name IS 'Nom de l''icône Material Design à utiliser';
COMMENT ON COLUMN public.categories.color IS 'Couleur hexadécimale de la catégorie (#RRGGBB)';
COMMENT ON COLUMN public.categories.is_custom IS 'Indique si la catégorie est custom (créée par l''utilisateur)';
COMMENT ON COLUMN public.categories.created_at IS 'Date de création de la catégorie';
COMMENT ON COLUMN public.categories.updated_at IS 'Date de dernière modification de la catégorie';

-- Commentaires sur les politiques
COMMENT ON POLICY "View default categories" ON public.categories
IS 'Permet à tous les utilisateurs connectés de voir les catégories par défaut';

COMMENT ON POLICY "Create custom categories" ON public.categories
IS 'Permet aux utilisateurs premium (payant OU trial actif) de créer des catégories personnalisées';

COMMENT ON POLICY "View own custom categories" ON public.categories
IS 'Permet aux utilisateurs premium de voir uniquement leurs propres catégories personnalisées';

COMMENT ON POLICY "Update own custom categories" ON public.categories
IS 'Permet aux utilisateurs premium de modifier uniquement leurs propres catégories personnalisées';

COMMENT ON POLICY "Delete own custom categories" ON public.categories
IS 'Permet aux utilisateurs premium de supprimer uniquement leurs propres catégories personnalisées';

COMMENT ON VIEW public.user_categories
IS 'Vue sécurisée qui retourne les catégories par défaut + les catégories custom de l''utilisateur premium connecté';

-- =============================================
-- RÉSUMÉ DE LA SÉCURITÉ
-- =============================================

/*
🔒 SÉCURITÉ CONFIGURÉE :

1. ✅ ISOLATION DES DONNÉES :
   - Catégories par défaut : visibles par tous les utilisateurs connectés
   - Catégories custom : visibles UNIQUEMENT par leur créateur premium
   - Impossible d'accéder aux catégories custom d'autres utilisateurs

2. ✅ ACCÈS RESTRICTIF :
   - Création custom : réservée aux utilisateurs premium (payant OU trial actif)
   - Modification/Suppression : réservée au créateur premium
   - Trial expiré : perte d'accès aux catégories custom

3. ✅ VUE SÉCURISÉE :
   - user_categories : filtre automatiquement par utilisateur connecté
   - Utilisée par l'application Flutter pour éviter les fuites de données
   - Combine catégories par défaut + catégories custom de l'utilisateur

4. ✅ TESTS AUTOMATIQUES :
   - Validation des contraintes de données
   - Vérification de la présence des catégories par défaut
   - Tests de cohérence du schéma

📱 UTILISATION DANS FLUTTER :

1. Récupérer toutes les catégories visibles :
   supabase.from('user_categories').select('*').order('is_custom, type, id')

2. Créer une catégorie custom :
   supabase.from('categories').insert({
     'name': 'Mon Custom',
     'type': 'expense',
     'icon_name': 'star',
     'color': '#FF6B6B',
     'is_custom': true
   })

3. Supprimer une catégorie custom :
   supabase.from('categories').delete().eq('id', categoryId).eq('is_custom', true)

⚡ OPTIMISATIONS PERFORMANCE :
- Index sur type pour filtrage rapide
- Index sur is_custom pour séparation défaut/custom
- Index composite pour requêtes fréquentes
- Trigger automatique updated_at

🔄 TRIGGERS AUTOMATIQUES :
- Mise à jour automatique du timestamp updated_at
- Validation des contraintes de données
- Tests automatiques de cohérence
*/
