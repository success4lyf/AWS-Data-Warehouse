import psycopg2
import os

def handler(event, context):
    print("event collected is {}".format(event))
  
    access_key_id = os.getenv('access_key_id')
    secret_access_key = os.getenv('secret_access_key')
    dbname = os.getenv('dbname')
    host = os.getenv('host')
    user = os.getenv('user')
    password = os.getenv('password')
    port = '5439'
    
    # Define connection string
    conn_string = "postgresql://{}:{}@{}:{}/{}".format(
        user,
        password,
        host,
        port,
        dbname
    )
    
    # Test connection
    conn = psycopg2.connect(conn_string)
    cur = conn.cursor()
    print('connected')
    
    # #load data
    store_table = """
        CREATE TABLE if not exists branch_sales(
          Transaction_Date DATE,
          Store_Name VARCHAR(250),
          Average_Spend DECIMAL(10,2),
          Total_Spend DECIMAL(10,2)
    );
    """
    cur.execute(store_table)
    
    transactions = """
        CREATE TABLE if not exists transactions(
            Transaction_id INT IDENTITY(1,1) PRIMARY KEY,
            Transaction_Date_Time TIMESTAMP,
            Store_Name VARCHAR(50),
            Total_price DECIMAL(10,2),
            Payment_Type VARCHAR(50)
        );
    """ 
    cur.execute(transactions)
    
    basket_items_table = """
        CREATE TABLE if not exists basket_items(
            Transaction_Id INT NOT NULL,
            Transaction_Date_Time TIMESTAMP,
            Product_Name VARCHAR(250),
            Product_Size VARCHAR(50),
            Product_Price DECIMAL(6,2),
            Branch_Name VARCHAR(250),
            FOREIGN KEY (Transaction_Id) REFERENCES transactions(Transaction_Id)
        );
        """
    cur.execute(basket_items_table)
    conn.commit()
    print('print successfully created table')
    
    file_path = "s3://etloadbuck/transformed/branch_sales_extracted/"
    file_path2 = "s3://etloadbuck/transformed/transaction_extracted/"
    file_path3 = "s3://etloadbuck/transformed/basket_item_extracted/"  
  
    sql_query = """
        COPY branch_sales
        FROM '{}'
        CREDENTIALS 'aws_access_key_id={};aws_secret_access_key={}'
        csv
        IGNOREHEADER 1 
        ;
    """.format(file_path,access_key_id,secret_access_key)   
    cur.execute(sql_query)
    conn.commit()
    
    sql_query2 = """
        COPY transactions
        FROM '{}'
        CREDENTIALS 'aws_access_key_id={};aws_secret_access_key={}'
        csv
        IGNOREHEADER 1
        ;
    """.format(file_path2,access_key_id,secret_access_key)    
    cur.execute(sql_query2)
    conn.commit()
    
    sql_query3 = """
        COPY basket_items
        FROM '{}'
        CREDENTIALS 'aws_access_key_id={};aws_secret_access_key={}'
        csv
        IGNOREHEADER 1 
        ;
    """.format(file_path3,access_key_id,secret_access_key)   
    cur.execute(sql_query3)
    conn.commit()

    cur.close()
    conn.close()
    print('successfully loaded')