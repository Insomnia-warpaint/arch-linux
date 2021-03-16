package com.aigao.manager.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @author insomnia
 * @date 2021/3/16 下午3:56
 * @effect
 */
public class MD5Utils {

    private static final char[] HEX_UPPER = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    private static final Logger logger = LogManager.getLogger(MD5Utils.class);
    private static String resultValue = null;
    private static final String SALT_VALUE = "INSOMNIA";
    private static MessageDigest instance = null;


    /**
     * 无盐加密
     * @param password MD5加密后生成32位(小写字母+数字)字符串
     * @return
     */
    public static String MD5ToLower(String password) {

        try {
            resultValue = password;
            // 获得MD5摘要算法的 MessageDigest 对象
            instance = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            instance.update(resultValue.getBytes(StandardCharsets.UTF_8));
            // digest()最后确定返回md5 hash值，返回值为8位字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            byte[] result = instance.digest();
            // BigInteger函数则将8位的字符串转换成16位hex值，用字符串来表示；得到字符串形式的hash值。1 固定值
            return new BigInteger(1, result).toString(16);

        } catch (NoSuchAlgorithmException e) {
            logger.debug("MD5 encryption fail" + e.getMessage());
        }
        return null;
    }

    /**
     * 无盐加密
     * @param password
     * @return MD5加密后生成32位(大写字母 + 数字)字符串
     */
    public static String MD5ToUpper(String password) {

        try {
            resultValue = password;
            // 获得MD5摘要算法的 MessageDigest 对象
            instance = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            instance.update(resultValue.getBytes(StandardCharsets.UTF_8));
            // digest()最后确定返回md5 hash值，返回值为8位字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            byte[] result = instance.digest();
            resultValue = byteArrayToUpperString(result);
            return resultValue;
        } catch (NoSuchAlgorithmException e) {
            logger.debug("MD5 encryption fail" + e.getMessage());
        }
        return null;
    }

    /**
     * @param password
     * @return
     */
    public static String saltValueMD5Upper(String password) {
        try {
            resultValue = password;
            // 获得MD5摘要算法的 MessageDigest 对象
            instance = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            instance.update(resultValue.getBytes(StandardCharsets.UTF_8));
            instance.update(SALT_VALUE.getBytes(StandardCharsets.UTF_8));
            // digest()最后确定返回md5 hash值，返回值为8位字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            byte[] result = instance.digest();
            resultValue = byteArrayToUpperString(result);
            logger.debug("盐值加密:------------------------------------------------------" + resultValue);
            return resultValue;
        } catch (NoSuchAlgorithmException e) {
            logger.debug("MD5 encryption fail" + e.getMessage());
        }
        return null;
    }

    public static String saltValueMD5Lower(String password) {
        try {
            resultValue = password;
            // 获得MD5摘要算法的 MessageDigest 对象
            instance = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            instance.update(resultValue.getBytes(StandardCharsets.UTF_8));
            instance.update(SALT_VALUE.getBytes(StandardCharsets.UTF_8));
            return new BigInteger(1, instance.digest()).toString(16);
        } catch (NoSuchAlgorithmException e) {
            logger.debug("MD5 encryption fail" + e.getMessage());
        }
        return null;
    }



    public static boolean valid(String password, String MD5Password) {
        return MD5Password.equals(MD5ToUpper(password)) || MD5Password.equals(MD5ToUpper(password).toLowerCase());
    }


    private static String byteArrayToUpperString(byte[] result) {
        int j = result.length;
        char[] chars = new char[j * 2];
        int k = 0;
        for (int i = 0; i < j; i++) {
            byte o = result[i];
            chars[k++] = HEX_UPPER[o >>> 4 & 0xf];  //0xf  取字节中高4，然后将结果与0x0F进行按位“与”
            chars[k++] = HEX_UPPER[o & 0xf]; //取字节中低 4 位的数字转换
        }

        return new String(chars);
    }


}
