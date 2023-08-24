package toyproject.demo.repository;

import toyproject.demo.domain.Message;

import java.util.List;

public interface MessageRepository {
    void send(Message message);
    List<Message> findAll(Message message);
    List<Message> findMessage(Message message);
    List<Message> search(Message message);
    void deleteAll(Message message);
    List<Message> delete(Message message);

}
