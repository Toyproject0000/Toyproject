package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

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
        mail.setContent(num);
        sendSimpleMessage(mail);
        return num;
    }

    private void sendSimpleMessage(Mail mail) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(mail.getAddress());
        message.setSubject(mail.getTitle());
        message.setText(mail.getContent());
        mailSender.send(message);
    }
}
