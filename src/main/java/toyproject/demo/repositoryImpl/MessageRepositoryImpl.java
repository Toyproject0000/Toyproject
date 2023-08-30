package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Message;
import toyproject.demo.repository.MessageRepository;

import java.time.LocalDateTime;
import java.util.*;

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
        String sql = "SELECT m.* FROM message m " +
                "WHERE (m.sendUser = ? OR m.acceptUser = ?) " +
                "AND m.date = (SELECT MAX(date) FROM message " +
                "              WHERE (sendUser = m.sendUser AND acceptUser = m.acceptUser) " +
                "                 OR (sendUser = m.acceptUser AND acceptUser = m.sendUser)) " +
                "GROUP BY m.sendUser, m.acceptUser";

        List<Message> messages = jdbcTemplate.query(sql, rowMapper, message.getSendUser(), message.getSendUser());

        return messages;
    }

    @Override
    public List<Message> findMessage(Message message) {
        return jdbcTemplate.query("select * from message where (senduser = ? and acceptuser = ?) or (senduser = ? and acceptuser = ?) ORDER BY date desc", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getAcceptUser(), message.getSendUser());
    }

    @Override
    public List<Message> search(Message message) {
        return jdbcTemplate.query("select * from message where (senduser = ? and acceptuser = ? and message = ?) or (senduser = ? and acceptuser = ? and message = ?) ORDER BY date desc", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getMessage(), message.getAcceptUser(), message.getSendUser(), message.getMessage());
    }

    @Override
    public void deleteAll(Message message) {
        jdbcTemplate.update("delete from message where senduser = ? and acceptuser = ?", message.getAcceptUser(), message.getSendUser());
        jdbcTemplate.update("delete from message where senduser = ? and acceptuser = ?", message.getSendUser(), message.getAcceptUser());
    }

    @Override
    public List<Message> delete(Message message) {
        System.out.println("message.getDate() = " + message.getDate());
        jdbcTemplate.update("delete from message where senduser = ? and acceptuser = ? and message = ? and date = ?", message.getSendUser(), message.getAcceptUser(), message.getMessage(), message.getDate());
        return null;
    }
}
