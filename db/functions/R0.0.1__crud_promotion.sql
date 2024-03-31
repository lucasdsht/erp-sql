DELIMITER //
CREATE PROCEDURE AddPromotion(IN _productID INT, IN _discountRate DECIMAL(5,2), IN _startDate DATE, IN _endDate DATE)
BEGIN
    INSERT INTO Promotion (ProductID, DiscountRate, StartDate, EndDate) VALUES (_productID, _discountRate, _startDate, _endDate);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetPromotion(IN _promotionID INT)
BEGIN
    SELECT * FROM Promotion WHERE PromotionID = _promotionID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdatePromotion(IN _promotionID INT, IN _productID INT, IN _discountRate DECIMAL(5,2), IN _startDate DATE, IN _endDate DATE)
BEGIN
    UPDATE Promotion
    SET ProductID = _productID, DiscountRate = _discountRate, StartDate = _startDate, EndDate = _endDate
    WHERE PromotionID = _promotionID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeletePromotion(IN _promotionID INT)
BEGIN
    DELETE FROM Promotion WHERE PromotionID = _promotionID;
END //
DELIMITER ;

