CREATE DATABASE IF NOT EXISTS Marketing_ERP;
USE Marketing_ERP;

CREATE TABLE Product (
  ProductId INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(255) NOT NULL,
  ProductDescription TEXT NOT NULL,
  ProductPrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Promotion (
  PromotionId INT PRIMARY KEY AUTO_INCREMENT,
  DiscountRate DECIMAL(5, 2) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  ProductId INT NOT NULL,
  FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

CREATE TABLE LastPromotion (
  LastPromotionId INT PRIMARY KEY AUTO_INCREMENT,
  PromotionId INT NOT NULL,
  UpdateDate DATETIME NOT NULL,
  FOREIGN KEY (PromotionId) REFERENCES Promotion(PromotionId)
);

