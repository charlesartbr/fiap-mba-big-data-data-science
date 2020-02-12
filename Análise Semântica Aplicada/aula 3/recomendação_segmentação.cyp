// Neo4J alterar nas configurações o diretório para D:/41bdt
// manage plugin APOC

//MATCH (n)
// DETACH DELETE n

CREATE (smartphones:Category {title: 'Smartphones'}), 
(notebooks:Category {title: 'Notebooks'}), 
(cameras:Category {title: 'Cameras'})

// Smartphones
CREATE (sony_xperia_z22:Product {title: 'Sony Experia Z22', price: 765.00, shippability: true, availability: true})
CREATE (samsung_galaxy_s8:Product {title: 'Samsung Galaxy S8', price: 784.00, shippability: true, availability: true})
CREATE (sony_xperia_xa1:Product {title: 'Sony Xperia XA1 Dual G3112', price: 229.50, shippability: true, availability: false})
CREATE (iphone_8:Product {title: 'Apple iPhone 8 Plus 64GB', price: 874.20, shippability: true, availability: false})
CREATE (xiaomi_mi_mix_2:Product {title: 'Xiaomi Mi Mix 2', price: 420.87, shippability: true, availability: true})
CREATE (huawei_p8:Product {title: 'Huawei P8 Lite', price: 191.00, shippability: true, availability: true})

MERGE (sony_xperia_z22)-[:IS_IN]->(smartphones)
MERGE (samsung_galaxy_s8)-[:IS_IN]->(smartphones)
MERGE (sony_xperia_xa1)-[:IS_IN]->(smartphones)
MERGE (iphone_8)-[:IS_IN]->(smartphones)
MERGE (xiaomi_mi_mix_2)-[:IS_IN]->(smartphones)
MERGE (huawei_p8)-[:IS_IN]->(smartphones)

// Notebooks
CREATE (acer_swift_3:Product {title: 'Acer Swift 3 SF314-51-34TX', price: 595.00, shippability: true, availability: false})
CREATE (hp_pro_book:Product {title: 'HP ProBook 440 G4', price: 771.30, shippability: true, availability: true})
CREATE (dell_inspiron_15:Product {title: 'Dell Inspiron 15 7577', price: 1477.50, shippability: true, availability: true})
CREATE (apple_macbook:Product {title: "Apple MacBook A1534 12' Rose Gold", price: 1293.00, shippability: false, availability: true})

MERGE (acer_swift_3)-[:IS_IN]->(notebooks)
MERGE (hp_pro_book)-[:IS_IN]->(notebooks)
MERGE (dell_inspiron_15)-[:IS_IN]->(notebooks)
MERGE (apple_macbook)-[:IS_IN]->(notebooks)

// Cameras
CREATE (canon_eos_6d:Product {title: 'Canon EOS 6D Mark II Body', price: 1794.00, shippability: true, availability: false})
CREATE (nikon_d7500:Product {title: 'Nikon D7500 Kit 18-105mm VR', price: 1612.35, shippability: true, availability: true})

MERGE (canon_eos_6d)-[:IS_IN]->(cameras)
MERGE (nikon_d7500)-[:IS_IN]->(cameras)

CREATE (joe:Customer {name: 'Joe Baxton', email: 'joeee_baxton@example.com', age: 25})
CREATE (daniel:Customer {name: 'Daniel Johnston', email: 'dan_j@example.com', age: 31})
CREATE (alex:Customer {name: 'Alex McGyver', email: 'mcgalex@example.com', age: 22})
CREATE (alisson:Customer {name: 'Allison York', email: 'ally_york1@example.com', age: 24})

MERGE (joe)-[:VIEWED {views_count: 15}]->(nikon_d7500)
MERGE (joe)-[:ADDED_TO_WISH_LIST]->(iphone_8)
MERGE (joe)-[:BOUGHT]->(apple_macbook)

MERGE(daniel)-[:VIEWED {views_count: 10}]->(sony_xperia_z22)
MERGE(daniel)-[:VIEWED {views_count: 20}]->(dell_inspiron_15)
MERGE(daniel)-[:ADDED_TO_WISH_LIST]->(dell_inspiron_15)

MERGE(alex)-[:VIEWED {views_count: 20}]->(canon_eos_6d)
MERGE(alex)-[:ADDED_TO_WISH_LIST]->(sony_xperia_xa1)
MERGE(alex)-[:ADDED_TO_WISH_LIST]->(nikon_d7500)
MERGE(alex)-[:BOUGHT]->(xiaomi_mi_mix_2)

MERGE(alisson)-[:ADDED_TO_WISH_LIST]->(acer_swift_3)
MERGE(alisson)-[:ADDED_TO_WISH_LIST]->(hp_pro_book)
MERGE(alisson)-[:BOUGHT]->(huawei_p8)
MERGE(alisson)-[:BOUGHT]->(sony_xperia_xa1);


MATCH (n) RETURN n;

Preferências para a categoria Notebooks

MATCH (:Customer)-[:ADDED_TO_WISH_LIST|:VIEWED]->(notebook:Product)-[:IS_IN]->(:Category {title: 'Notebooks'})
RETURN notebook;

criar uma promoção para os produtos preferenciais

CREATE(offer:PromotionalOffer {type: 'discount_offer', content: 'Notebooks discount offer...'})
WITH offer
MATCH (:Customer)-[:ADDED_TO_WISH_LIST|:VIEWED]->(notebook:Product)-[:IS_IN]->(:Category {title: 'Notebooks'})
MERGE(offer)-[:USED_TO_PROMOTE]->(notebook);

visualizar as mudanças no grafo
MATCH (offer:PromotionalOffer)-[:USED_TO_PROMOTE]->(product:Product) 
RETURN offer, product;

identificar os clientes que visualizaram os produtos

MATCH (offer:PromotionalOffer {type: 'discount_offer'})-[:USED_TO_PROMOTE]->(product:Product)<-[:ADDED_TO_WISH_LIST|:VIEWED]-(customer:Customer) 
RETURN offer, product, customer;


criar uma oferta promocional para um cliente específico

MATCH (alex:Customer {name: 'Alex McGyver'})
MATCH (free_product:Product)
WHERE NOT ((alex)-->(free_product))
MATCH (product:Product)
WHERE ((alex)-->(product))

MATCH (free_product)-[:IS_IN]->()<-[:IS_IN]-(product)
WHERE ((product.price - product.price * 0.20) >= free_product.price <= (product.price + product.price * 0.20))

RETURN free_product;

agora olhando free_Produto

MATCH (alex:Customer {name: 'Alex McGyver'})
MATCH (free_product:Product)
WHERE NOT ((alex)-->(free_product))
MATCH (product:Product)
WHERE ((alex)-->(product))

MATCH (free_product)-[:IS_IN]->()<-[:IS_IN]-(product)
WHERE ((product.price - product.price * 0.20) >= free_product.price <= (product.price + product.price * 0.20))

CREATE(offer:PromotionalOffer {type: 'personal_replacement_offer', content: 'Personal replacement offer for ' + alex.name})
WITH offer, free_product, alex
MERGE(offer)-[rel:USED_TO_PROMOTE {email: alex.email}]->(free_product)
RETURN offer, free_product, rel;


criando recomendação
MATCH (customer:Customer)-->(product:Product) 
RETURN customer, product;


MATCH (:Customer {name: 'Alex McGyver'})-->(product:Product)<--(customer:Customer)
MATCH (customer)-->(customer_product:Product)
WHERE (customer_product <> product)
RETURN customer, customer_product;

