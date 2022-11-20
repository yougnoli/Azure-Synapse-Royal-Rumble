/*

Piu' il SERVERLESS POOL conosce i miei dati e piu' potra' eseguire velocemente le mie query. Chi fa questo per noi e' il QUERY OPTIMIZER del SERVERLESS POOL che autonomamente sceglie
il piano di esecuzione migliore e meno costoso. In molti dei casi sceglie quello che performa piu' velocemente.

Quando una query viene eseguita il QUERY OPTIMIZER vede che ha bisogno delle statistiche per creare il PIANO DI ESECUZIONE migliore.
    1. Ha la crezione automatica delle statistiche per una colonna (nel caso non dovessero essere gia' presenti).
       Al primo lancio della query ci sara' un leggero ritardo perche' le sta creando autonomamente. Dopo il primo lancio quelle statistiche
       saranno riutilizzate per le seguenti query. (Al momento NON esiste la creazione automatica delle statiche per csv su external tables)
    2. Creazione delle proprie statistiche (per )
Le STATISTICHE sono legate ad una particolare TABELLA, COLONNA e DATATYPE


Esempio di esecuzione di una query (primo lancio)

Verranno create:
    1. Global Statistics Query -> statistiche create al momento del lancio della query dal query optimizer
    2. Internal Cardinality Query -> stima il numero delle righe prendendo un campione dei dati + calcola la lunghezza media della colonna di tipo "character" (se dovesse essere presente)
Si possono vedere queste 2 cose create nella sezione MONITOR -> SQL REQUESTS.
Al prossimo lancio di questa query verrano riutilizzati questi 2 oggetti.
*/
SELECT
    subcategory
    ,count(subcategory) as num_subcategory
FROM
    OPENROWSET(
        BULK 'https://dlsyntestmm.dfs.core.windows.net/container01/sanfrancisco/parquet/year=2001/**',
        FORMAT = 'PARQUET'
    ) AS [result]
GROUP BY subcategory
GO

/*
Esempio di esecuzione di una query dove come target c'e' un' altra colonna (non character di data type) 
Non e' presente la creazione dell'Internal Cardinality Query perche' NON e' una colonna di tipo character.
Rimane presente la creazione delle statistiche.
*/
SELECT
    DISTINCT latitude
FROM
    OPENROWSET(
        BULK 'https://dlsyntestmm.dfs.core.windows.net/container01/sanfrancisco/parquet/year=2001/**',
        FORMAT = 'PARQUET'
    ) AS [result]
GO
