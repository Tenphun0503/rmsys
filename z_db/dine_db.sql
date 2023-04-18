/*
Server Type    : MYSQL
Host           : localhost:3306
Database       : dine_db

Schema for building tables of dine_db

Date: 04-15-2023 22:55:40
*/

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `nickname` varchar(50) NOT NULL COMMENT 'Nickname',
  `sex` tinyint(4) NOT NULL COMMENT '0-F 1-M',
  `phone` varchar(11) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL COMMENT 'label for this address',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Set as default address 0-false 1-true',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT 'Set as deleted 0-false 1-true',
  PRIMARY KEY (`id`) USING BTREE
) COMMENT='Address management information';

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES ('1417414526093082626', '1417012167126876162', 'Jack', '1', '2023725555', '2322 Virginia Av NW', null, null, null, 'Company', '1', '2023-04-15 17:22:12', '2023-04-15 17:26:33', '1417012167126876162', '1417012167126876162', '0');
INSERT INTO `address_book` VALUES ('1417414926166769666', '1417012167126876162', 'Jack', '1', '2023752654', '1891 Putnam Av', null, null, null, 'Home', '0', '2023-04-15 17:23:47', '2023-04-15 17:23:47', '1417012167126876162', '1417012167126876162', '0');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `type` int(11) DEFAULT NULL COMMENT 'Type: 1 Dish-Classification 2 SetMeal-Classification',
  `name` varchar(64) NOT NULL COMMENT 'Classification name',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT 'sorting order',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_category_name` (`name`)
) COMMENT='Classification of dishes and sets';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1397844263642378242', '1', 'Hunan Cuisine', '1', '2023-03-07 09:16:58', '2023-03-09 20:25:23', '1', '1');
INSERT INTO `category` VALUES ('1397844303408574465', '1', 'Sichuan Cuisine', '2', '2023-03-07 09:17:07', '2023-03-09 14:27:22', '1', '1');
INSERT INTO `category` VALUES ('1397844391040167938', '1', 'Cantonese Cuisine', '3', '2023-03-07 09:17:28', '2023-03-09 14:37:13', '1', '1');
INSERT INTO `category` VALUES ('1413341197421846529', '1', 'Drinks', '11', '2023-03-09 11:36:15', '2023-03-09 14:39:15', '1', '1');
INSERT INTO `category` VALUES ('1413342269393674242', '2', 'Top Set', '5', '2023-03-09 11:40:30', '2023-03-09 14:43:45', '1', '1');
INSERT INTO `category` VALUES ('1413384954989060097', '1', 'Meals', '12', '2023-03-09 14:30:07', '2023-03-09 14:39:19', '1', '1');
INSERT INTO `category` VALUES ('1413386191767674881', '2', 'Children Set', '6', '2023-03-09 14:35:02', '2023-03-09 14:39:05', '1', '1');

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `id` bigint(20) NOT NULL,
  `name` varchar(64) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `code` varchar(64) NOT NULL,
  `image` varchar(200) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0-sold-out 1-available',
  `order` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT 'Set as deleted 0-false 1-true',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_dish_name` (`name`)
) COMMENT='Dish information';

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES ('1397849739276890114', 'Spicy Chicken', '1397844263642378242', '7800.00', '222222222', 'f966a38e-0780-40be-bb52-5699d13cb3d9.jpg', 'From tender and delicious chicken, worth a try', '1', '0', '2023-03-07 09:38:43', '2023-03-07 09:38:43', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397850140982161409', 'Mao''s Braised Pork', '1397844263642378242', '6800.00', '123412341234', '0a3b3288-3446-4420-bbff-f263d0c02d8e.jpg', 'Mao''s Braised Pork Mao''s Braised Pork, are you sure you want some?', '1', '0', '2023-03-07 09:40:19', '2023-03-07 09:40:19', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397850392090947585', 'Zuan shark fin', '1397844263642378242', '4800.00', '123412341234', '740c79ce-af29-41b8-b78d-5f49c96e38c4.jpg', 'Zuan shark fin, the picture is enough to show how delicious it is', '1', '0', '2023-03-07 09:41:19', '2023-03-07 09:41:19', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397850851245600769', 'Farewell My Concubine', '1397844263642378242', '12800.00', '123412341234', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 'What could be more delicious than Farewell My Concubine?？', '1', '0', '2023-03-07 09:43:08', '2023-03-07 09:43:08', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397851099502260226', 'Hotchpotch', '1397844263642378242', '11800.00', '23412341234', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 'Don''t just eat meat, let''s have a hotchpotch, let you live long and delicious', '1', '0', '2023-03-07 09:44:08', '2023-03-07 09:44:08', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397851370462687234', 'Shaoyang Pig Blood Balls', '1397844263642378242', '13800.00', '1246812345678', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 'Look, isn''t it delicious? Come on, come on, this is my favorite', '1', '0', '2023-03-07 09:45:12', '2023-03-07 09:45:12', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397851668262465537', 'Taste snake', '1397844263642378242', '16800.00', '1234567812345678', '0f4bd884-dc9c-4cf9-b59e-7d5958fec3dd.jpg', 'The leader in the reptile world, Dongxing-taste snake, makes you want to stop', '1', '0', '2023-03-07 09:46:23', '2023-03-07 09:46:23', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397852391150759938', 'Gongpao Chicken', '1397844303408574465', '8800.00', '2346812468', 'ef2b73f2-75d1-4d3a-beea-22da0e1421bd.jpg', 'Gongpao Chicken, Gongpao Chicken, Eternal Soul', '1', '0', '2023-03-07 09:49:16', '2023-03-07 09:49:16', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397853183287013378', 'Spicy Rabbit Head', '1397844303408574465', '19800.00', '123456787654321', '2a2e9d66-b41d-4645-87bd-95f2cfeed218.jpg', 'The detailed production of spicy rabbit head, spicy and delicious, ruddy color, long aftertaste', '1', '0', '2023-03-07 09:52:24', '2023-03-07 09:52:24', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397853709101740034', 'Garlic Pork', '1397844303408574465', '9800.00', '1234321234321', 'd2f61d70-ac85-4529-9b74-6d9a2255c6d7.jpg', 'what an appetite', '1', '0', '2023-03-07 09:54:30', '2023-03-07 09:54:30', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397853890262118402', 'Fish-Flavored Shredded Pork', '1397844303408574465', '3800.00', '1234212321234', '8dcfda14-5712-4d28-82f7-ae905b3c2308.jpg', 'Fish-flavored shredded pork is simply a classic dish in our childhood memories.', '1', '0', '2023-03-07 09:55:13', '2023-03-07 09:55:13', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397854652581064706', 'Spicy Boiled Fish', '1397844303408574465', '14800.00', '2345312·345321', '1fdbfbf3-1d86-4b29-a3fc-46345852f2f8.jpg', 'The fish fillets are bought and cut fish fillets, put a few shrimps to increase the taste', '1', '0', '2023-03-07 09:58:15', '2023-03-07 09:58:15', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397854865672679425', 'Fish Fragrant Scrambled Eggs', '1397844303408574465', '2000.00', '23456431·23456', '0f252364-a561-4e8d-8065-9a6797a6b1d3.jpg', 'Fish coriander is also a characteristic of Sichuan cuisine. There is no fish in it but the smell of fish', '1', '0', '2023-03-07 09:59:06', '2023-03-07 09:59:06', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397860242057375745', 'Crispy Roast Goose', '1397844391040167938', '12800.00', '123456786543213456', 'e476f679-5c15-436b-87fa-8c4e9644bf33.jpeg', 'As the most common and popular barbecue meat in Guangzhou', '1', '0', '2023-03-07 10:20:27', '2023-03-07 10:20:27', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397860578738352129', 'Poached Chicken', '1397844391040167938', '6600.00', '12345678654', '9ec6fc2d-50d2-422e-b954-de87dcd04198.jpeg', 'White-cut chicken is a characteristic traditional dish with complete color, flavor and taste', '1', '0', '2023-03-07 10:21:48', '2023-03-07 10:21:48', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397860792492666881', 'Roast suckling pig', '1397844391040167938', '38800.00', '213456432123456', '2e96a7e3-affb-438e-b7c3-e1430df425c9.jpeg', 'This dish is mainly made by roasting the ingredients in charcoal fire.', '1', '0', '2023-03-07 10:22:39', '2023-03-07 10:22:39', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397860963880316929', 'Crispy Pigeon', '1397844391040167938', '10800.00', '1234563212345', '3fabb83a-1c09-4fd9-892b-4ef7457daafa.jpeg', '"Crispy Pigeon" is a famous traditional dish in Cantonese cuisine. It belongs to Cantonese cuisine. It has the characteristics of crispy skin and tender meat, bright red color, and delicious fragrance.', '1', '0', '2023-03-07 10:23:19', '2023-03-07 10:23:19', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397861683434139649', 'Steamed River Seafood', '1397844391040167938', '38800.00', '1234567876543213456', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 'Steaming is the most classic cooking method in Guangzhou.', '1', '0', '2023-03-07 10:26:11', '2023-03-07 10:26:11', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397862198033297410', 'Old fire soup', '1397844391040167938', '49800.00', '123456786532455', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 'Laohuo soup, also known as Guangfu soup, is a secret recipe of food tonic and health preservation that has been passed down by people in Guangfu for thousands of years.', '1', '0', '2023-03-07 10:28:14', '2023-03-07 10:28:14', '1', '1', '0');
INSERT INTO `dish` VALUES ('1397862477831122945', 'Baked Lobster in Soup', '1397844391040167938', '108800.00', '1234567865432', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 'Baked Lobster in Soup is a famous traditional dish with complete color, flavor and taste, which belongs to Cantonese cuisine.', '1', '0', '2023-03-07 10:29:20', '2023-03-07 10:29:20', '1', '1', '0');
INSERT INTO `dish` VALUES ('1413342036832100354', 'Water', '1413341197421846529', '500.00', '', 'c99e0aab-3cb7-4eaa-80fd-f47d4ffea694.png', '', '1', '0', '2023-03-09 11:39:35', '2023-03-09 15:12:18', '1', '1', '0');
INSERT INTO `dish` VALUES ('1413384757047271425', 'Tea', '1413341197421846529', '500.00', '', '00874a5e-0df2-446b-8f69-a30eb7d88ee8.png', '', '1', '0', '2023-03-09 14:29:20', '2023-03-12 09:09:16', '1', '1', '0');
INSERT INTO `dish` VALUES ('1413385247889891330', 'Rice', '1413384954989060097', '200.00', '', 'ee04a05a-1230-46b6-8ad5-1a95b140fff3.png', '', '1', '0', '2023-03-09 14:31:17', '2023-03-11 16:35:26', '1', '1', '0');

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor` (
  `id` bigint(20) NOT NULL,
  `dish_id` bigint(20) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(500) DEFAULT NULL COMMENT 'Taste data list',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT 'Set as deleted 0-false 1-true',
  PRIMARY KEY (`id`) USING BTREE
) COMMENT='Dish-Taste relationship information';

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES ('1397849417888346113', '1397849417854791681', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:37:27', '2023-03-07 09:37:27', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397849739297861633', '1397849739276890114', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:38:43', '2023-03-07 09:38:43', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397849739323027458', '1397849739276890114', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:38:43', '2023-03-07 09:38:43', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397849936421761025', '1397849936404983809', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:39:30', '2023-03-07 09:39:30', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397849936438538241', '1397849936404983809', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:39:30', '2023-03-07 09:39:30', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850141015715841', '1397850140982161409', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:40:19', '2023-03-07 09:40:19', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850141040881665', '1397850140982161409', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:40:19', '2023-03-07 09:40:19', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850392120307713', '1397850392090947585', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:41:19', '2023-03-07 09:41:19', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850392137084929', '1397850392090947585', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:41:19', '2023-03-07 09:41:19', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850630734262274', '1397850630700707841', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:42:16', '2023-03-07 09:42:16', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850630755233794', '1397850630700707841', 'spiciness', '[\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:42:16', '2023-03-07 09:42:16', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850851274960898', '1397850851245600769', 'diet', '[\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:43:08', '2023-03-07 09:43:08', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397850851283349505', '1397850851245600769', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:43:08', '2023-03-07 09:43:08', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851099523231745', '1397851099502260226', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:44:08', '2023-03-07 09:44:08', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851099527426050', '1397851099502260226', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\"]', '2023-03-07 09:44:08', '2023-03-07 09:44:08', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851370483658754', '1397851370462687234', 'temperature', '["hot\",\"cold\",\"no ice\",\"less ice\",\"more ice\"]', '2023-03-07 09:45:12', '2023-03-07 09:45:12', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851370483658755', '1397851370462687234', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:45:12', '2023-03-07 09:45:12', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851370483658756', '1397851370462687234', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:45:12', '2023-03-07 09:45:12', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397851668283437058', '1397851668262465537', 'temperature', '[\"hot\",\"cold\",\"no ice\",\"less ice\",\"more ice\"]', '2023-03-07 09:46:23', '2023-03-07 09:46:23', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397852391180120065', '1397852391150759938', 'diet', '[\"no onion\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:49:16', '2023-03-07 09:49:16', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397852391196897281', '1397852391150759938', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"heavy spicy\"]', '2023-03-07 09:49:16', '2023-03-07 09:49:16', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397853183307984898', '1397853183287013378', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:52:24', '2023-03-07 09:52:24', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397853423486414850', '1397853423461249026', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:53:22', '2023-03-07 09:53:22', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397853709126905857', '1397853709101740034', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:54:30', '2023-03-07 09:54:30', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397853890283089922', '1397853890262118402', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:55:13', '2023-03-07 09:55:13', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397854133632413697', '1397854133603053569', 'temperature', '[\"hot\",\"cold\",\"no ice\",\"less ice\",\"more ice\"]', '2023-03-07 09:56:11', '2023-03-07 09:56:11', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397854652623007745', '1397854652581064706', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 09:58:15', '2023-03-07 09:58:15', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397854652635590658', '1397854652581064706', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:58:15', '2023-03-07 09:58:15', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397854865735593986', '1397854865672679425', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 09:59:06', '2023-03-07 09:59:06', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397855742303186946', '1397855742273826817', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:02:35', '2023-03-07 10:02:35', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397855906497605633', '1397855906468245506', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 10:03:14', '2023-03-07 10:03:14', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397856190573621250', '1397856190540066818', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:04:21', '2023-03-07 10:04:21', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397859056709316609', '1397859056684150785', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:15:45', '2023-03-07 10:15:45', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397859277837217794', '1397859277812051969', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:16:37', '2023-03-07 10:16:37', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397859487502086146', '1397859487476920321', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:17:27', '2023-03-07 10:17:27', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397859757061615618', '1397859757036449794', 'sugar', '[\"no sugar\",\"less sugar\",\"half sugar\",\"more sugar\",\"full sugar\"]', '2023-03-07 10:18:32', '2023-03-07 10:18:32', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397860242086735874', '1397860242057375745', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:20:27', '2023-03-07 10:20:27', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397860963918065665', '1397860963880316929', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:23:19', '2023-03-07 10:23:19', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397861135754506242', '1397861135733534722', 'sugar', '[\"no sugar\",\"less sugar\",\"half sugar\",\"more sugar\",\"full sugar\"]', '2023-03-07 10:24:00', '2023-03-07 10:24:00', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397861370035744769', '1397861370010578945', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-07 10:24:56', '2023-03-07 10:24:56', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397861683459305474', '1397861683434139649', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 10:26:11', '2023-03-07 10:26:11', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397861898467717121', '1397861898438356993', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 10:27:02', '2023-03-07 10:27:02', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397862198054268929', '1397862198033297410', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-07 10:28:14', '2023-03-07 10:28:14', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1397862477835317250', '1397862477831122945', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\"]', '2023-03-07 10:29:20', '2023-03-07 10:29:20', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398089545865015297', '1398089545676271617', 'temperature', '[\"hot\",\"cold\",\"no ice\",\"less ice\",\"more ice\"]', '2023-03-08 01:31:38', '2023-03-08 01:31:38', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398089782323097601', '1398089782285348866', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:32:34', '2023-03-08 01:32:34', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398090003262255106', '1398090003228700673', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-08 01:33:27', '2023-03-08 01:33:27', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398090264554811394', '1398090264517062657', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-08 01:34:29', '2023-03-08 01:34:29', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398090455399837698', '1398090455324340225', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:35:14', '2023-03-08 01:35:14', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398090685449023490', '1398090685419663362', 'temperature', '[\"hot\",\"cold\",\"no ice\",\"less ice\",\"more ice\"]', '2023-03-08 01:36:09', '2023-03-08 01:36:09', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398090825358422017', '1398090825329061889', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-08 01:36:43', '2023-03-08 01:36:43', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398091007051476993', '1398091007017922561', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:37:26', '2023-03-08 01:37:26', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398091296164851713', '1398091296131297281', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:38:35', '2023-03-08 01:38:35', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398091546531246081', '1398091546480914433', 'diet', '[\"no onion\",\"no garlic\",\"no coriander\",\"no spicy\"]', '2023-03-08 01:39:35', '2023-03-08 01:39:35', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398091729809747969', '1398091729788776450', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:40:18', '2023-03-08 01:40:18', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398091889499484161', '1398091889449152513', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:40:56', '2023-03-08 01:40:56', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398092095179763713', '1398092095142014978', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:41:45', '2023-03-08 01:41:45', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398092283877306370', '1398092283847946241', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:42:30', '2023-03-08 01:42:30', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398094018939236354', '1398094018893099009', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:49:24', '2023-03-08 01:49:24', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1398094391494094850', '1398094391456346113', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-08 01:50:53', '2023-03-08 01:50:53', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1399574026165727233', '1399305325713600514', 'spiciness', '[\"not spicy\",\"slightly spicy\",\"medium spicy\",\"heavy spicy\"]', '2023-03-01 03:50:25', '2023-03-01 03:50:25', '1399309715396669441', '1399309715396669441', '0');
INSERT INTO `dish_flavor` VALUES ('1413389540592263169', '1413384757047271425', 'temperature', '[\"normal\",\"iced\"]', '2023-03-12 09:09:16', '2023-03-12 09:09:16', '1', '1', '0');
INSERT INTO `dish_flavor` VALUES ('1413389684020682754', '1413342036832100354', 'temperature', '[\"normal\",\"iced\"]', '2023-03-09 15:12:18', '2023-03-09 15:12:18', '1', '1', '0');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL,
  `name` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `sex` varchar(2) NOT NULL,
  `id_number` varchar(18) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'status 0-disabled, 1-normal',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`)
) COMMENT='Employee Information';

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', 'administrator', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '2023725622', '1', '540102188115122512', '1', '2023-03-06 17:20:07', '2023-03-10 02:24:09', '1', '1');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `number` varchar(50) DEFAULT NULL COMMENT 'order number',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Order status: 1-pending payment, 2-pending delivery, 3-delivered, 4-completed, 5-canceled',
  `user_id` bigint(20) NOT NULL COMMENT 'Order user',
  `address_book_id` bigint(20) NOT NULL,
  `order_time` datetime NOT NULL,
  `checkout_time` datetime NOT NULL,
  `pay_method` int(11) NOT NULL DEFAULT '1' COMMENT 'Payment method 1-creditCard, 2-ApplePay',
  `amount` decimal(10,2) NOT NULL COMMENT 'Amount received',
  `remark` varchar(100) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
);

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT 'name of the dish',
  `image` varchar(100) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `dish_id` bigint(20) DEFAULT NULL,
  `setmeal_id` bigint(20) DEFAULT NULL,
  `dish_flavor` varchar(50) DEFAULT NULL,
  `number` int(11) NOT NULL DEFAULT '1',
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) COMMENT='Order Details';

-- ----------------------------
-- Records of order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `name` varchar(64) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` int(11) DEFAULT NULL COMMENT 'status 0-disabled, 1-normal',
  `code` varchar(32) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT 'Set as deleted 0-false 1-true',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_setmeal_name` (`name`)
) COMMENT='set meal Information';

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES ('1415580119015145474', '1413386191767674881', 'Children''s Meal Plan A', '4000.00', '1', '', '', '61d20592-b37f-4d72-a864-07ad5bb8f3bb.jpg', '2023-03-15 15:52:55', '2023-03-15 15:52:55', '1415576781934608386', '1415576781934608386', '0');

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish` (
  `id` bigint(20) NOT NULL,
  `setmeal_id` varchar(32) NOT NULL,
  `dish_id` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `copies` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_user` bigint(20) NOT NULL,
  `update_user` bigint(20) NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT 'Set as deleted 0-false 1-true',
  PRIMARY KEY (`id`) USING BTREE
) COMMENT='Set & dishes relation information';

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES ('1415580119052894209', '1415580119015145474', '1397862198033297410', 'Laohuo soup', '49800.00', '1', '0', '2023-03-15 15:52:55', '2023-03-15 15:52:55', '1415576781934608386', '1415576781934608386', '0');
INSERT INTO `setmeal_dish` VALUES ('1415580119061282817', '1415580119015145474', '1413342036832100354', 'Water', '500.00', '1', '0', '2023-03-15 15:52:55', '2023-03-15 15:52:55', '1415576781934608386', '1415576781934608386', '0');
INSERT INTO `setmeal_dish` VALUES ('1415580119069671426', '1415580119015145474', '1413385247889891330', 'Rice', '200.00', '1', '0', '2023-03-15 15:52:55', '2023-03-15 15:52:55', '1415576781934608386', '1415576781934608386', '0');

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `dish_id` bigint(20) DEFAULT NULL,
  `setmeal_id` bigint(20) DEFAULT NULL,
  `dish_flavor` varchar(50) DEFAULT NULL,
  `number` int(11) NOT NULL DEFAULT '1',
  `amount` decimal(10,2) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
);

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(100) NOT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `id_number` varchar(18) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT 'status 0-disabled, 1-normal',
  PRIMARY KEY (`id`) USING BTREE
) COMMENT='User Information';
