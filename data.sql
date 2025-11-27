-- ===========================================
--  DONNÉES : CATEGORIES
--  Objectif : insérer les catégories de produits
--  TODO : compléter le nom de la table et la liste des colonnes (hors colonne d'identifiant)
-- Exemple attendu :
--   INSERT INTO categories (name, description) VALUES ...
-- ===========================================

INSERT INTO categories (name_cat, description_cat) VALUES
  ('Électronique',       'Produits high-tech et accessoires'),
  ('Maison & Cuisine',   'Électroménager et ustensiles'),
  ('Sport & Loisirs',    'Articles de sport et plein air'),
  ('Beauté & Santé',     'Produits de beauté, hygiène, bien-être'),
  ('Jeux & Jouets',      'Jouets pour enfants et adultes');



-- ===========================================
--  DONNÉES : PRODUITS
--  Objectif : insérer les produits
--  Colonnes métiers attendues (à déduire) :
--    - nom du produit
--    - prix
--    - stock
--    - catégorie (clé étrangère vers la table des catégories)
--  TODO : compléter le INSERT INTO avec le nom de la table et la liste des colonnes (hors ID)
-- ===========================================

-- ===========================================
-- DONNÉES : PRODUITS
-- ===========================================
INSERT INTO products (name_prod, price, stock, id_cat)
SELECT p.name, p.price, p.stock, c.id_cat
FROM (VALUES
    ('Casque Bluetooth X1000',        79.99, 50, 'Électronique'),
    ('Souris Gamer Pro RGB',          49.90, 120, 'Électronique'),
    ('Bouilloire Inox 1.7L',          29.99, 80, 'Maison & Cuisine'),
    ('Aspirateur Cyclonix 3000',     129.00, 40, 'Maison & Cuisine'),
    ('Tapis de Yoga Comfort+',        19.99, 150, 'Sport & Loisirs'),
    ('Haltères 5kg (paire)',          24.99, 70, 'Sport & Loisirs'),
    ('Crème hydratante BioSkin',      15.90, 200, 'Beauté & Santé'),
    ('Gel douche FreshEnergy',         4.99, 300, 'Beauté & Santé'),
    ('Puzzle 1000 pièces "Montagne"', 12.99, 95, 'Jeux & Jouets'),
    ('Jeu de société "Galaxy Quest"', 29.90, 60, 'Jeux & Jouets')
) AS p(name_prod, price, stock, category_name)
JOIN categories c ON c.name_cat = p.category_name;




-- ===========================================
--  DONNÉES : CLIENTS
--  Objectif : insérer les clients
--  Colonnes métiers attendues (à déduire) :
--    - prénom
--    - nom
--    - email
--    - date/heure de création du compte
--  TODO : compléter le INSERT INTO avec le nom de la table et les colonnes (hors ID)
-- ===========================================

INSERT INTO customers (first_name, last_name, email, created_at) VALUES
  ('Alice',  'Martin',    'alice.martin@mail.com',    '2024-01-10 14:32'),
  ('Bob',    'Dupont',    'bob.dupont@mail.com',      '2024-02-05 09:10'),
  ('Chloé',  'Bernard',   'chloe.bernard@mail.com',   '2024-03-12 17:22'),
  ('David',  'Robert',    'david.robert@mail.com',    '2024-01-29 11:45'),
  ('Emma',   'Leroy',     'emma.leroy@mail.com',      '2024-03-02 08:55'),
  ('Félix',  'Petit',     'felix.petit@mail.com',     '2024-02-18 16:40'),
  ('Hugo',   'Roussel',   'hugo.roussel@mail.com',    '2024-03-20 19:05'),
  ('Inès',   'Moreau',    'ines.moreau@mail.com',     '2024-01-17 10:15'),
  ('Julien', 'Fontaine',  'julien.fontaine@mail.com', '2024-01-23 13:55'),
  ('Katia',  'Garnier',   'katia.garnier@mail.com',   '2024-03-15 12:00');



-- ===========================================
--  DONNÉES : COMMANDES
--  Objectif : insérer les commandes
--  Colonnes métiers attendues (à déduire) :
--    - client (référence vers la table des clients)
--    - date/heure de la commande
--    - statut (PENDING, PAID, SHIPPED, CANCELLED)
--  Remarque : le client est identifié ici par son email,
--             à vous d'utiliser cet email pour retrouver l'ID du client si nécessaire.
--  TODO : ajuster les colonnes du INSERT INTO selon votre modèle
-- ===========================================

INSERT INTO orders (id_customer, order_date, order_status)
SELECT c.id_customer, o.order_date, o.order_status
FROM (
    VALUES
      ('alice.martin@mail.com', '2024-03-01 10:20', 'PAID'),
      ('bob.dupont@mail.com',   '2024-03-04 09:12', 'SHIPPED'),
      ('chloe.bernard@mail.com','2024-03-08 15:02', 'PAID'),
      ('david.robert@mail.com', '2024-03-09 11:45', 'CANCELLED'),
      ('emma.leroy@mail.com',   '2024-03-10 08:10', 'PAID'),
      ('felix.petit@mail.com',  '2024-03-11 13:50', 'PENDING'),
      ('hugo.roussel@mail.com', '2024-03-15 19:30', 'SHIPPED'),
      ('ines.moreau@mail.com',  '2024-03-16 10:00', 'PAID'),
      ('julien.fontaine@mail.com','2024-03-18 14:22','PAID'),
      ('katia.garnier@mail.com','2024-03-20 18:00', 'PENDING')
) AS o(email, order_date, order_status)
JOIN customers c ON o.email = c.email;



-- ===========================================
--  DONNÉES : LIGNES DE COMMANDE (ORDER_ITEMS)
--  Objectif : insérer le détail des commandes
--  Colonnes métiers attendues (à déduire) :
--    - référence à la commande
--    - référence au produit
--    - quantité
--    - prix unitaire facturé
--  Remarque :
--    - Ici les commandes et produits sont identifiés par email + date et nom de produit.
--      À vous d'écrire les requêtes nécessaires ou d'adapter les insertions
--      pour référencer les bons IDs (order_id, product_id) selon votre modèle.
-- ===========================================

INSERT INTO order_items(order_id, product_id, quantity, unit_price) VALUES
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'alice.martin@mail.com'
     AND o.order_date = '2024-03-01 10:20'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Casque Bluetooth X1000'),
  1, 79.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'alice.martin@mail.com'
     AND o.order_date = '2024-03-01 10:20'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Puzzle 1000 pièces "Montagne"'),
  2, 12.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'bob.dupont@mail.com'
     AND o.order_date = '2024-03-04 09:12'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Tapis de Yoga Comfort+'),
  1, 19.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'chloe.bernard@mail.com'
     AND o.order_date = '2024-03-08 15:02'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Bouilloire Inox 1.7L'),
  1, 29.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'chloe.bernard@mail.com'
     AND o.order_date = '2024-03-08 15:02'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Gel douche FreshEnergy'),
  3, 4.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'david.robert@mail.com'
     AND o.order_date = '2024-03-09 11:45'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Haltères 5kg (paire)'),
  1, 24.99
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'emma.leroy@mail.com'
     AND o.order_date = '2024-03-10 08:10'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Crème hydratante BioSkin'),
  2, 15.90
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'julien.fontaine@mail.com'
     AND o.order_date = '2024-03-18 14:22'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Jeu de société "Galaxy Quest"'),
  1, 29.90
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'katia.garnier@mail.com'
     AND o.order_date = '2024-03-20 18:00'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Souris Gamer Pro RGB'),
  1, 49.90
),
(
  (SELECT o.order_id FROM orders o 
   JOIN customers c ON c.id = o.id_customer
   WHERE c.email = 'katia.garnier@mail.com'
     AND o.order_date = '2024-03-20 18:00'),
  (SELECT p.id FROM products p WHERE p.product_name = 'Gel douche FreshEnergy'),
  2, 4.99
);
