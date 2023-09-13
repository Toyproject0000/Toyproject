package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.FCMNotificationRequestDto;
import toyproject.demo.domain.Message;
import toyproject.demo.repository.MessageRepository;

import java.util.List;
import java.util.Optional;
@Service
@RequiredArgsConstructor
public class MessageService {
    private final MessageRepository messageRepository;
    private final FCMNotificationService fcmNotificationService;

    public String send(Message message) {
        try {
            messageRepository.send(message);
            FCMNotificationRequestDto fcm = new FCMNotificationRequestDto();
            fcm.setTargetUserId(message.getAcceptUser());
            fcm.setTitle("새로운 메시지 도착");
            fcm.setBody(message.getSendUser()+"님에게 메세지가 도착했습니다.");
            fcmNotificationService.sendNotificationByToken(fcm);
        }catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public Optional<List<Message>> findAll(Message message) {
        List<Message> messages;

        messages = messageRepository.findAll(message);

        return Optional.ofNullable(messages);
    }

    public Optional<List<Message>> findMessage(Message message) {
        List<Message> messages;
        try {
            messages = messageRepository.findMessage(message);
        }
        catch (Exception e){
            return null;
        }
        return Optional.ofNullable(messages);
    }

    public Optional<List<Message>> search(Message message) {
        List<Message> messages;
        try {
            messages = messageRepository.search(message);
        }
        catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return null;
        }
        return Optional.ofNullable(messages);
    }

    public String deleteAll(Message message) {
        try {
            messageRepository.deleteAll(message);
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String delete(Message message) {
        try {
            messageRepository.delete(message);
        }catch (Exception e){
            return "cancel";
        }
        return "ok";
    }
}
