DELIMITER //
CREATE TRIGGER AfterPromotionInsert
AFTER INSERT ON Promotions
FOR EACH ROW
BEGIN
    INSERT INTO LastPromotion (PromotionID, UpdateDate)
    VALUES (NEW.PromotionID, NOW())
    ON DUPLICATE KEY UPDATE UpdateDate = NOW();
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER AfterPromotionUpdate
AFTER UPDATE ON Promotions
FOR EACH ROW
BEGIN
    INSERT INTO LastPromotion (PromotionID, UpdateDate)
    VALUES (NEW.PromotionID, NOW())
    ON DUPLICATE KEY UPDATE UpdateDate = NOW();
END //
DELIMITER ;
