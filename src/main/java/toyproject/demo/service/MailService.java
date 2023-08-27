package toyproject.demo.service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Mail;

import java.util.Random;

@Service
@RequiredArgsConstructor
public class MailService {
    private final JavaMailSender mailSender;

    public String sendMail(String id){
        Mail mail = new Mail();
        mail.setAddress(id);
        Random random = new Random();
        String num = String.valueOf(random.nextInt(100000, 1000000));
        mail.setContentForJoin(num);
        sendHtmlMail(mail);
        return num;
    }

    public void sendHtmlMail(Mail mail) {
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(mail.getAddress());
            helper.setSubject(mail.getTitle());
            helper.setText(mail.getContent(), true);
            mailSender.send(message);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}