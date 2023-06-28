package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;
import toyproject.demo.repository.ReplyRepository;

import java.util.List;

@Repository
public class ReplyRepositoryImpl implements ReplyRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Reply> rowMapper;

    public ReplyRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(Reply.class);
    }

    @Override
    public void insert(Reply reply) {
        jdbcTemplate.update("insert into reply (userId, postId, contents) values (?,?,?)",
                reply.getUserId(), reply.getPostId(), reply.getContents());
    }

    @Override
    public void update(Reply reply) {
        jdbcTemplate.update("update reply set userId = ?, postId = ?, contents = ? where id = ? ",
                reply.getUserId(), reply.getPostId(), reply.getContents(), reply.getId());
    }

    @Override
    public void delete(Reply reply) {
        jdbcTemplate.update("delete from reply where id = ?", reply.getId());
    }

    @Override
    public List<Reply> findAll() {
        return jdbcTemplate.query("select * from reply", rowMapper);
    }

    @Override
    public List<Reply> findReplyOfPost(Post post) {
        return jdbcTemplate.query("select * from reply where postId = ?", rowMapper, post.getId());
    }

    @Override
    public List<Reply> findReplyOfUser(User user) {
        return jdbcTemplate.query("select * from reply where userId = ?", rowMapper, user.getId());
    }
}
