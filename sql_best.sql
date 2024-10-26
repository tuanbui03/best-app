-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dbbest
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(950) DEFAULT NULL,
  `image` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (2,'MKB','MKB is one of the famous dog food brands in the Asian pet industry. The company was founded in 2008 and its main business includes premium pet food, snacks, treats, supplies, and accessories for dogs and cats. Currently, MKB\'s products serve the needs of millions of pets, they are sold to more than 30 countries around the world.','assets/images/brands/makar-300x300.jpg'),(4,'BOBO','BoBo is a trademark of the company “Zhejiang Bobo Pet Articles Co.,Ltd.”. As one of the enterprises specializing in exploiting, manufacturing and exporting pet products. Currently, the BoBo brand is distributed in many countries around the world such as the US, Japan, European countries... In Vietnam, BoBo products are distributed in a system of Pet Mart stores nationwide. .','assets/images/brands/bobo-3-300x300.jpg'),(5,'LOFFE','Branded backpacks, bags, and pet carriers','assets/images/brands/bowwow-300x300.jpg'),(40,'PURINA PRO PLAN','PURINA PRO PLAN provides advanced nutrition for dogs and cats of all ages, personalities and breeds. With continuously improved formulas by a team of more than 500 nutritionists, veterinarians and scientists... PURINA PRO PLAN is formulated to help pets thrive at all stages of life. The product offers a delicious flavor combination that will satisfy even the pickiest of pets.','assets/images/brands/purina-pro-plan-300x300.jpg'),(41,'AUPET','Toilets, transport cages, chairs, cages... AUPET dogs and cats at Pet Mart Vietnam are supplied by the manufacturer AUPET. This is one of the major companies specializing in manufacturing plastic products for pets. The company was established in 1995. With more than 20 years of operation, AUPET has accumulated a full range of experience in its manufacturing field. Through attention to detail and shape. AUPET designers strive to create better pet products. Contribute to improving the lives of four-legged friends. That\'s why AUPET pet products are trusted by all customers around the world.','assets/images/brands/aupet-300x300.jpg');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(450) DEFAULT NULL,
  `image` varchar(450) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (12,'Home','Set of 6-panel Collared Dog and Cat Kennel with Diamond Door with a design consisting of powder-coated iron mesh panels securely joined together.','assets/images/products/nha-o-cho-cho-meo-hinh-giang-sinh-paw-green-christmas3-400x400.jpg'),(13,'Food','Belongs to the product line of high-quality soft grain food for pets','assets/images/products/th (5).jpg'),(14,'Clothes','Online shopping for Pet Supplies from a great selection of Shirts, Cold Weather Coats, Costumes, Bandanas, Dresses, Sweaters & more at everyday low prices.','assets/images/products/th (5).png'),(15,'Accessory','Great dog and cat accessory made of soft and airy fabric, with a pretty gold coin shape on the top.','assets/images/products/th (6).jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES (1,'Green'),(2,'Red'),(3,'Blue'),(4,'Pink'),(5,'Grey'),(6,'Purple'),(7,'Black'),(8,'White'),(9,'Yellow'),(10,'Brown'),(11,'Teal'),(12,'Indigo');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `content` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `vote` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userID-feebackID_idx` (`user_id`),
  KEY `f.productID-p.productID_idx` (`product_id`),
  CONSTRAINT `f.productID-p.id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `f.userID-u.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (26,27,1,'Good',5,'2024-04-19 15:43:10');
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_recipient`
--

DROP TABLE IF EXISTS `message_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_recipient` (
  `id` int NOT NULL,
  `message_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mr.user_id-u.id` (`user_id`),
  KEY `mr.message_id-m.id` (`message_id`),
  CONSTRAINT `mr.message_id-m.id` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `mr.user_id-u.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_recipient`
--

LOCK TABLES `message_recipient` WRITE;
/*!40000 ALTER TABLE `message_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_sample`
--

DROP TABLE IF EXISTS `message_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_sample` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shop_id` int DEFAULT NULL,
  `question` varchar(450) DEFAULT NULL,
  `answer` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m.shop_id-s.id` (`shop_id`),
  CONSTRAINT `m.shop_id-s.id` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_sample`
--

LOCK TABLES `message_sample` WRITE;
/*!40000 ALTER TABLE `message_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message_sample_id` int NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `date_read` datetime DEFAULT NULL,
  `content` varchar(900) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `s.user_id-u.id` (`user_id`),
  KEY `m.message_sample_id-m.id` (`message_sample_id`),
  CONSTRAINT `m.message_sample_id-m.id` FOREIGN KEY (`message_sample_id`) REFERENCES `message_sample` (`id`),
  CONSTRAINT `s.user_id-u.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `warehouse_voucher_id` int DEFAULT NULL,
  `product_detail_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `od.orderID-o.orderID_idx` (`order_id`),
  KEY `od.productID-pd.id_idx` (`product_detail_id`),
  KEY `ob.warehose_voucherID-wv.id_idx` (`warehouse_voucher_id`),
  CONSTRAINT `ob.warehose_voucherID-wv.id` FOREIGN KEY (`warehouse_voucher_id`) REFERENCES `warehouse_voucher` (`id`),
  CONSTRAINT `od.orderID-o.id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `od.productID-pd.id` FOREIGN KEY (`product_detail_id`) REFERENCES `product_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (238,78,1,248,1,45),(239,78,1,240,30,45),(240,78,1,273,1,120),(241,78,12,267,1,63),(242,79,1,242,1,45),(243,79,1,271,1,120),(244,79,1,266,2,63);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `address` varchar(250) NOT NULL,
  `total` double NOT NULL,
  `created_at` datetime NOT NULL,
  `phone` varchar(10) NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserID-o.userID_idx` (`user_id`),
  KEY `o.paymentID-p.paymentID_idx` (`payment_id`),
  CONSTRAINT `o.paymentID-p.id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  CONSTRAINT `o.userID-u.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (77,3,1,'',0,'2024-04-19 10:33:07','',1),(78,27,1,'ab',1571.7,'2024-04-19 15:42:47','1234567890',0),(79,27,1,'',0,'2024-04-19 15:42:47','',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(450) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'Payment upon delivery (COD)','Cash on delivery (COD) is a type of transaction where the recipient pays for a good at the time of delivery rather than using credit. The terms and accepted forms of payment vary according to the payment provisions of the purchase agreement. Cash on delivery is also referred to as \"collect on delivery\" since delivery may allow for cash, check, or electronic payment.'),(2,'Bank Account Transfer','A bank transfer is a transaction that moves money from one bank account to another, either electronically or via a check. A bank transfer can be internal, meaning the transfer occurs between accounts at the same bank, or external, with funds transferred between accounts at two different banks.');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_color`
--

DROP TABLE IF EXISTS `product_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_color` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color_id` int NOT NULL,
  `image` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i.productID-p.productID_idx` (`product_id`),
  KEY `i.colorID-c.colorID_idx` (`color_id`),
  CONSTRAINT `pc.colorID-c.id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `pc.productID-p.id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_color`
--

LOCK TABLES `product_color` WRITE;
/*!40000 ALTER TABLE `product_color` DISABLE KEYS */;
INSERT INTO `product_color` VALUES (115,1,7,'assets/images/products/balo1.jpg'),(116,1,3,'assets/images/products/balo2.jpg'),(117,1,4,'assets/images/products/balo3.jpg'),(118,1,5,'assets/images/products/balo5.jpg'),(119,1,9,'assets/images/products/balo4.jpg'),(120,34,3,'assets/images/products/food1.jpg'),(121,34,1,'assets/images/products/food2.jpg'),(122,34,4,'assets/images/products/food3.jpg'),(123,35,6,'assets/images/products/house1.jpg'),(124,35,3,'assets/images/products/house2.jpg'),(125,35,2,'assets/images/products/house3.jpg'),(126,36,2,'assets/images/products/food_mkb1.jpg'),(127,36,7,'assets/images/products/food_mkb2.jpg'),(128,37,2,'assets/images/products/vong1.jpg'),(129,37,3,'assets/images/products/vong2.jpg'),(130,37,9,'assets/images/products/vong3.jpg');
/*!40000 ALTER TABLE `product_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_detail`
--

DROP TABLE IF EXISTS `product_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_size_id` int NOT NULL,
  `product_color_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pd.product_sizeID-ps.ID_idx` (`product_size_id`),
  KEY `pd.imageID-i.imageID_idx` (`product_color_id`),
  CONSTRAINT `pd.imageID-pc.id` FOREIGN KEY (`product_color_id`) REFERENCES `product_color` (`id`),
  CONSTRAINT `pd.product_sizeID-ps.ID` FOREIGN KEY (`product_size_id`) REFERENCES `product_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_detail`
--

LOCK TABLES `product_detail` WRITE;
/*!40000 ALTER TABLE `product_detail` DISABLE KEYS */;
INSERT INTO `product_detail` VALUES (240,111,115,0),(241,112,115,33),(242,113,115,36),(243,111,116,60),(244,112,116,66),(245,113,116,72),(246,111,117,90),(247,112,117,0),(248,113,117,101),(249,111,118,300),(250,112,118,330),(251,113,118,360),(252,111,119,3),(253,112,119,0),(254,113,119,0),(255,114,120,200),(256,115,120,300),(257,114,121,20),(258,115,121,30),(259,114,122,0),(260,115,122,10),(261,116,123,100),(262,117,123,200),(263,118,123,300),(264,116,124,25),(265,117,124,0),(266,118,124,35),(267,116,125,49),(268,117,125,0),(269,118,125,0),(270,119,126,100),(271,120,126,200),(272,119,127,0),(273,120,127,299),(274,121,128,50),(275,122,128,60),(276,123,128,70),(277,121,129,80),(278,122,129,90),(279,123,129,100),(280,121,130,0),(281,122,130,5),(282,123,130,3);
/*!40000 ALTER TABLE `product_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_size`
--

DROP TABLE IF EXISTS `product_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_size` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p.productID_ps.productID_idx` (`product_id`),
  KEY `s.sizeID_ps.sizeID_idx` (`size_id`),
  CONSTRAINT `ps.productID-p.id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `ps.sizeID-s.id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_size`
--

LOCK TABLES `product_size` WRITE;
/*!40000 ALTER TABLE `product_size` DISABLE KEYS */;
INSERT INTO `product_size` VALUES (111,1,11),(112,1,14),(113,1,17),(114,34,1),(115,34,11),(116,35,6),(117,35,11),(118,35,16),(119,36,1),(120,36,11),(121,37,5),(122,37,8),(123,37,11);
/*!40000 ALTER TABLE `product_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(650) NOT NULL,
  `brand_id` int NOT NULL,
  `category_id` int NOT NULL,
  `shop_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  `description` varchar(1000) NOT NULL,
  `code` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `discount` int NOT NULL,
  `sold` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p.brandID-b.id` (`brand_id`),
  KEY `p.categoryID-c.id` (`category_id`),
  KEY `p.shop_Id-s.id` (`shop_id`),
  CONSTRAINT `p.brandID-b.id` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `p.categoryID-c.id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `p.shop_Id-s.id` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'LOFFE Panoramic astronaut dog and cat backpack',5,15,3,469,50,'LOFFE Panoramic astronaut dog and cat backpack is a space bag product used to transport, carry, and store pets such as small and medium-sized dogs, cats, rabbits, and hamsters. The product comes with 2 convex caps and air vents.\n\nMain benefits\nCreate a more enjoyable and safer space for pets. Allows pets to enjoy the sun, scenery and interact with the outside world.\nTransporting pets to go out and travel with this product will make you feel happy beyond your own imagination.\nThe product is integrated with a safety chain, ventilation mesh, and soft lining to make pets feel comfortable, convenient, and safe.\nNon-toxic materials: Cotton, ABS, PC, Polyester, EPE, Acrylic... can be completely washed in warm water and soap.','LOFFE_Panoramic',10,31,'2024-03-22 16:08:29',1),(34,'PURINA PRO PLAN Small & Mini Puppy puppy food',40,13,3,500,60,'PURINA PRO PLAN Small & Mini Puppy (Dry Dog Food) pure chicken flavor helps balance and complete small and mini dog breeds with an adult weight of less than 10kg. Product used for puppies under 12 months old.','Purina_Food',20,0,'2024-04-19 12:50:06',1),(35,'Plastic house for dogs and cats shaped like eggs AUPET Egg House',41,12,3,299,90,'AUPET Egg House is suitable for all dog and cat breeds. The product includes 1 toilet tray and 1 pad.  Main benefits AUPET Egg House is inspired by the lovely egg shell shape. Create a quiet living space with modern dog and pet colors. The material is safe for pets, highly durable, easy to clean and can be used in all seasons. The product is friendly to all premises and home interiors.','Plastic_House',30,1,'2024-04-19 12:58:35',1),(36,'MKB Breed & Train Nutrition Mass Gainer Dog Food',2,13,27,999,120,'MKB Breed & Train Nutrition Mass Gainer dog food helps gain weight and develop muscles for healthy dogs.  This is a high-quality food product specifically designed to help your dog gain weight and develop muscle effectively. The unique formula contains high-quality ingredients such as fresh poultry, salmon and fresh vegetables, providing a large amount of protein and essential nutrients to help your dog gain weight safely. whole and healthy.','MKB_Breed',0,1,'2024-04-19 13:55:02',1),(37,'Dog and cat collar with mini leash',4,15,27,300,35,'Mini dog and cat collar with leash is made of 100% high quality nylon material, extremely durable and sturdy. For small dogs, kittens and cats.','Mini_',5,0,'2024-04-19 14:01:49',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shops` (
  `id` int NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `s.id-u.id` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
INSERT INTO `shops` VALUES (3,'Shop','assets/images/products/shop.jpg','Bach Khoa','tuan@gmail.com','1234567890'),(27,'TuanSky','assets/images/products/shop2.jpg','Ha Noi','tuan@gmail.com','1234567890');
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,20),(2,21),(3,22),(4,23),(5,24),(6,25),(7,26),(8,27),(9,28),(10,29),(11,30),(12,31),(13,32),(14,33),(15,34),(16,35),(17,36),(18,37),(19,38),(20,39),(21,40),(22,41),(23,42),(24,43),(25,44),(26,45);
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `password` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `gender` int DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  `phone` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(450) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `birthday` datetime NOT NULL,
  `role` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'Sh','op','Shop','Shop@12345',0,'Shop@gmail.com','assets/images/users/th (1).jpg','1234567890','','2024-01-02 00:00:00',1,1),(11,'Ad','min','Admin','Admin@12345',1,'Ad@gmail.com','assets/images/users/th (4).jpg','1234567890','','2024-02-28 00:00:00',0,1),(27,'Bui','Tuan','TuanBui123','Tuan@12345',0,'Tuan@gmail.com','assets/images/users/account1.jpg','1234567890','N/A','2024-01-26 07:00:00',1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `shop_id` int NOT NULL,
  `product_id` int NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `discount_percent` int NOT NULL,
  `description` varchar(450) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `v.product_id-p.id` (`product_id`),
  KEY `v.shop_id-shop.id` (`shop_id`),
  CONSTRAINT `v.product_id-p.id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `v.shop_id-shop.id` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchers`
--

LOCK TABLES `vouchers` WRITE;
/*!40000 ALTER TABLE `vouchers` DISABLE KEYS */;
INSERT INTO `vouchers` VALUES (1,'free',3,1,'2024-03-29 07:00:00','2024-03-29 07:00:00',0,'free'),(31,'V_plastic_house',3,35,'2024-04-19 07:00:00','2024-04-26 07:00:00',10,'v_plastic_house'),(32,'MiniLeash',27,37,'2024-04-20 07:00:00','2024-04-27 07:00:00',10,'1');
/*!40000 ALTER TABLE `vouchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_voucher`
--

DROP TABLE IF EXISTS `warehouse_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `voucher_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wv.user_id-u.user_id` (`user_id`),
  KEY `wv.voucher_id-v.id` (`voucher_id`),
  CONSTRAINT `wv.user_id-u.user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wv.voucher_id-v.id` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_voucher`
--

LOCK TABLES `warehouse_voucher` WRITE;
/*!40000 ALTER TABLE `warehouse_voucher` DISABLE KEYS */;
INSERT INTO `warehouse_voucher` VALUES (1,3,1),(12,27,31);
/*!40000 ALTER TABLE `warehouse_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userID-w.puserID_idx` (`user_id`),
  KEY `w.productID-p.productID_idx` (`product_id`),
  CONSTRAINT `w.productID-p.id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `w.userID-u.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
INSERT INTO `wishlists` VALUES (44,1,3,'2024-04-19 13:18:45',NULL),(45,1,27,'2024-04-19 22:44:46',NULL);
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20  0:28:17
