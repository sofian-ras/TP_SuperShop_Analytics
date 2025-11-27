import psycopg

conn = psycopg.connect(
    host="localhost",
    port=5432,
    dbname="database_commerce",
    user="admin",
    password="admin123"
)

def client_by_date():
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM customers ORDER BY created_at;")
            rows = cur.fetchall()
            print("\nclients triés par date de création (ancien -> récent) :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)


def product_list_by_price():
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT name_prod, price FROM products ORDER BY price DESC;")
            rows = cur.fetchall()
            print("\nproduits (nom + prix) triés par prix décroissant :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)


def order_by_date_to_date():
    try:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT * FROM orders WHERE order_date BETWEEN '2024-03-01' AND '2024-03-15';"
            )
            rows = cur.fetchall()
            print("\ncommandes passées entre le 1er et le 15 mars 2024 :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)


def products_greater_than_50():
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT name_prod, price FROM products WHERE price > 50;")
            rows = cur.fetchall()
            print("\nproduits dont le prix est strictement supérieur à 50 € :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)


def products_by_category():
    try:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT p.name_prod, p.price, p.stock
                FROM products p
                JOIN categories c ON p.id_cat = c.id_cat
                WHERE c.name_cat = 'Électronique';
                """
            )
            rows = cur.fetchall()
            print("\ntous les produits de la catégorie 'Électronique' :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)

def products_with_category():
    try:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT p.name_prod, p.price, c.name_cat
                FROM products p
                JOIN categories c ON p.id_cat = c.id_cat;
                """
            )
            rows = cur.fetchall()
            print("\nliste de tous les produits avec le nom de leur catégorie :")
            for r in rows:
                print(r)
    except Exception as e:
        print("Erreur :", e)



conn.close()
print("\n=== Fin des rapports ===")
