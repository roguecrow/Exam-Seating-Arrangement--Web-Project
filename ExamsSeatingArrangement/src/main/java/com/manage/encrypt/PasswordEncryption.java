package com.manage.encrypt;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

import javax.crypto.Cipher;

public class PasswordEncryption {
	
	  static String publicKey="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCATl5fra4Jsk/UZXGIvF1P44uFkKjsxtnyHtD1M18MLwtpaFVahsTNfDyVn5GL/zYUMS5tj2oFQwBr4YbB9Q+5b9MTI8m9ehSm5f/CbyTF+aSVUym7aRPbWPA6fioB5fiiIH29wUlCksPBb1ePxi+fSAuHLXIaMLdgissuZI+LbQIDAQAB";
      static String privateKey="MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAIBOXl+trgmyT9RlcYi8XU/ji4WQqOzG2fIe0PUzXwwvC2loVVqGxM18PJWfkYv/NhQxLm2PagVDAGvhhsH1D7lv0xMjyb16FKbl/8JvJMX5pJVTKbtpE9tY8Dp+KgHl+KIgfb3BSUKSw8FvV4/GL59IC4ctchowt2CKyy5kj4ttAgMBAAECgYAGwJkU3fYPypOK8P/Fm2wpvSblk5RgSaLErDyA+wAgiwVFudjsF7WZvtUNZsVpIbg93cy8tVR2DG2kP80wve3i2FKFuftHa8kcq0TK0vnyYtwl9RnPyyzP1qzD1gV4lprhzneHHiNzqh/rLTYWddpMz99NV9YRT/ZchbeMLFrDIQJBAKmZu3D1Q5pYYu/tXI3Ko/wv5YBfZdvjTYuzG+G1kGDEfSoWxg8AHDtaklXnVnJ0Z2C1n3wz/tI946c7CvhF7cUCQQDBq0X+6NufauG7639bPt2Rym33xXF1/JiHM0i2Vh1YHVOyr0sAQNnr9wElEm274s4L/nPkWk0Y4FOwRM8Jf+mJAkEAk8ZGgxrBJ6fhtOodndI15hOZpav5pYk9VP7fyV+ZCCfMYzLqqcFP2AuHu9/Q+/Me7C30Y5Uub+PLCzgvy7mqfQJBAKWWLTiwG+eH2Q11YuS/MW6Pp8prFIGOwVMHtCnCI0DNglyKqBPFXw3zmRT7VruIRifXHXunAbg9RRC3JFW4+hECQE9BEvvy0b3Up4lYu9XzIDgcTrJrQmVih7nly5GzMlI4dOflHcezd/9n6zKCb1+xSh4i1goMvlvpmL/N9sCcZic=";
      
      public String encrypt(String message) throws Exception {
    	  
          byte[] publicKeyBytes = Base64.getDecoder().decode(publicKey.getBytes());
          KeyFactory keyFactory = KeyFactory.getInstance("RSA");
          X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
          PublicKey publicKey =  keyFactory.generatePublic(publicKeySpec);

          Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
          cipher.init(Cipher.ENCRYPT_MODE, publicKey);

          return Base64.getEncoder().encodeToString(cipher.doFinal(message.getBytes(StandardCharsets.UTF_8)));
      }

      public String decrypt(String encryptedMessage) throws Exception {
    	  
          byte[] privateKeyBytes = Base64.getDecoder().decode(privateKey.getBytes());
          PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
          KeyFactory keyFactory = KeyFactory.getInstance("RSA");

          PrivateKey privateKey= keyFactory.generatePrivate(privateKeySpec);

          Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
          cipher.init(Cipher.DECRYPT_MODE, privateKey);
          return new String(cipher.doFinal(Base64.getDecoder().decode(encryptedMessage)), StandardCharsets.UTF_8);
      }

}
