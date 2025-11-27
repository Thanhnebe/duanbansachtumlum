USE livingword;
GO

-- Tạo bảng cart_items
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cart_items]') AND type in (N'U'))
BEGIN
    CREATE TABLE cart_items (
        id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL DEFAULT 1,
        updated_at DATETIME NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
        UNIQUE (user_id, product_id) 
    );
    
    CREATE INDEX idx_cart_items_user_id ON cart_items(user_id);
    CREATE INDEX idx_cart_items_product_id ON cart_items(product_id);
    
    PRINT 'Bảng cart_items đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng cart_items đã tồn tại.';
END
GO

