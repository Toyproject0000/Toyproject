package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Message;
import toyproject.demo.repository.MessageRepository;

import java.util.List;
import java.util.Optional;
@Service
@RequiredArgsConstructor
public class MessageService {
    private final MessageRepository messageRepository;

    public String send(Message message) {
        try {
            messageRepository.send(message);
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
            return null;
        }
        return Optional.ofNullable(messages);
    }

    public String deleteAll(Message message) {
        try {
            messageRepository.deleteAll(message);
        }catch (Exception e){
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
