package toyproject.demo.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import toyproject.demo.domain.message.MessagesDto;
import toyproject.demo.domain.message.SmsRequest;
import toyproject.demo.domain.message.SmsResponse;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

@Service
public class SmsService {

        @Value("ncp:sms:kr:304952565611:toyproject")
        private String serviceId;
        @Value("zDH2ZfbJFJoDLDpJ8MC3")
        private String accessKey;
        @Value("KaHFgDXwqRAZiTqUKskW2sCLKt0BRefJiVfjr9Ld")
        private String secretKey;


        public SmsResponse sendSms(String recipientPhoneNumber) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, URISyntaxException, JsonProcessingException {
            Long time = System.currentTimeMillis();
            List<MessagesDto> messages = new ArrayList<>();
            messages.add(new MessagesDto(recipientPhoneNumber, "인증번호자리"));

            SmsRequest smsRequest = new SmsRequest("SMS", "COMM", "82", "01077611776", "내용", messages);
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonBody = objectMapper.writeValueAsString(smsRequest);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-ncp-apigw-timestamp", time.toString());
            headers.set("x-ncp-iam-access-key", this.accessKey);
            String sig = makeSignature(time); //암호화
            headers.set("x-ncp-apigw-signature-v2", sig);

            HttpEntity<String> body = new HttpEntity<>(jsonBody,headers);

            RestTemplate restTemplate = new RestTemplate();
            restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            SmsResponse smsResponse = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+this.serviceId+"/messages"), body, SmsResponse.class);

            return smsResponse;

        }
        public String makeSignature(Long time) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {

            String space = " ";
            String newLine = "\n";
            String method = "POST";
            String url = "/sms/v2/services/"+ this.serviceId+"/messages";
            String timestamp = time.toString();
            String accessKey = this.accessKey;
            String secretKey = this.secretKey;

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
