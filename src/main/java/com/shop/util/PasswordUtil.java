package com.shop.util;

import java.security.MessageDigest;
import java.util.Base64;

public class PasswordUtil {
    public static String hashPassword(String plain) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] digest = md.digest(plain.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(digest);
    }

    public static boolean verifyPassword(String plain, String hash) throws Exception {
        return hashPassword(plain).equals(hash);
    }
}
