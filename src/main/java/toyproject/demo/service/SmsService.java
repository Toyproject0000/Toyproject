package toyproject.demo.service;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@Service
public class SmsService {

    public void sendSms(String to, String random) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
        String currentTimestamp = String.valueOf(System.currentTimeMillis());
        headers.set("x-ncp-apigw-timestamp", currentTimestamp);
        headers.set("x-ncp-iam-access-key", "zDH2ZfbJFJoDLDpJ8MC3");
        headers.set("x-ncp-apigw-signature-v2", makeSignature());

        String url = "https://sens.apigw.ntruss.com/sms/v2/services/ncp:sms:kr:304952565611:toyproject/messages";

        String requestBody = "{\n" +
                "    \"type\":\"SMS\",\n" +
                "    \"contentType\":\"COMM\",\n" +
                "    \"countryCode\":\"82\",\n" +
                "    \"from\":\"01077611776\",\n" +
                "    \"subject\":\"확인\",\n" +
                "    \"content\":\"테스트\",\n" +
                "    \"messages\":[\n" +
                "        {\n" +
                "            \"to\":"+"\""+to+"\",\n" +
                "            \"subject\":\"확인\",\n" +
                "            \"content\":\"인증번호는 "+random+"입니다.\"\n" +
                "        }\n" +
                "    ]\n" +
                "}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        System.out.println(response.getBody());
    }



    public String makeSignature() throws NoSuchAlgorithmException, InvalidKeyException, UnsupportedEncodingException {
        String space = " ";					// one space
        String newLine = "\n";					// new line
        String method = "POST";					// method
        String url = "/sms/v2/services/ncp:sms:kr:304952565611:toyproject/messages";	// url (include query string)
        String currentTimestamp = String.valueOf(System.currentTimeMillis());
        String timestamp = currentTimestamp;			// current timestamp (epoch)
        String accessKey = "zDH2ZfbJFJoDLDpJ8MC3";			// access key id (from portal or Sub Account)
        String secretKey = "KaHFgDXwqRAZiTqUKskW2sCLKt0BRefJiVfjr9Ld";

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        String encodeBase64String = Base64.encodeBase64String(rawHmac);

        return encodeBase64String;
    }
}
