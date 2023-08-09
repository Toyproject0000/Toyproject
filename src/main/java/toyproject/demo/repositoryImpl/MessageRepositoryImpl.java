package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Message;
import toyproject.demo.repository.MessageRepository;

import java.time.LocalDateTime;
import java.util.List;

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
        return jdbcTemplate.query("SELECT * FROM message " +
                "WHERE (sendUser = ? AND acceptUser = ?) " +
                "   OR (sendUser = ? AND acceptUser = ?) " +
                "ORDER BY dateTime DESC " +
                "LIMIT 1;", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getAcceptUser(), message.getSendUser());
    }

    @Override
    public List<Message> findMessage(Message message) {
        return jdbcTemplate.query("select * from message where senduser = ? and acceptuser = ?", rowMapper, message.getSendUser(), message.getAcceptUser());
    }

    @Override
    public List<Message> search(Message message) {
        return jdbcTemplate.query("select * from message where senduser = ? and acceptuser = ? and message = ?", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getMessage());
    }

    @Override
    public List<Message> deleteAll(Message message) {
        return jdbcTemplate.query("delete from message where senduser = ? and acceptuser = ?", rowMapper, message.getSendUser(), message.getAcceptUser());
    }

    @Override
    public List<Message> delete(Message message) {
        return jdbcTemplate.query("delete from message where senduser = ? and acceptuser = ? and message = ?", rowMapper, message.getSendUser(), message.getAcceptUser(), message.getMessage());

    }
}
