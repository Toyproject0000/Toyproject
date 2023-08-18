package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Message;
import toyproject.demo.repository.MessageRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class MessageRepositoryImpl implements MessageRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper = BeanPropertyRowMapper.newInstance(Message.class);
    @Override
    public void send(Message message) {
        jdbcTemplate.update("insert into message (senduser, acceptuser, message, date) values (?,?,?,?)", message.getSendUser(), message.getAcceptUser(), message.getMessage(), LocalDateTime.now());
    }

    @Override
    public List<Message> findAll(Message message) {
        String query = "SELECT * FROM message " +
                "WHERE (sendUser = ? OR acceptUser = ?) " +
                "ORDER BY dateTime DESC;";

        List<Message> messages = jdbcTemplate.query(query, rowMapper, message.getSendUser(), message.getSendUser());

        Map<String, Message> latestMessages = new HashMap<>();

        for (Message findmessage : messages) {
            String otherUser = findmessage.getSendUser().equals("UserA") ? findmessage.getAcceptUser() : findmessage.getSendUser();

            if (!latestMessages.containsKey(otherUser)) {
                latestMessages.put(otherUser, findmessage);
            }
        }

        return new ArrayList<>(latestMessages.values());
    }

    @Override
    public List<Message> findMessage(Message message) {
        return jdbcTemplate.query("select * from message where senduser = ? and acceptuser = ?", rowMapper, message.getSendUser(), message.getSendUser());
    }

    @Override
    public List<Message> search(Message message) {
        return jdbcTemplate.query("select * from message where senduser = ? and acceptuser = ? and message = ?", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getMessage());
    }

    @Override
    public List<Message> deleteAll(Message message) {
        jdbcTemplate.query("delete from message where senduser = ? and acceptuser = ?", rowMapper, message.getAcceptUser(), message.getSendUser());
        return jdbcTemplate.query("delete from message where senduser = ? and acceptuser = ?", rowMapper, message.getSendUser(), message.getAcceptUser());
    }

    @Override
    public List<Message> delete(Message message) {
        return jdbcTemplate.query("delete from message where senduser = ? and acceptuser = ? and message = ? and date = ?", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getMessage(), message.getDateTime());

    }
}
