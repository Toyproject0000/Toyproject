package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.repository.ReplyLikeRepository;

public class ReplyLikeRepositoryImpl implements ReplyLikeRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;

    public ReplyLikeRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(ReplyLike.class);
    }

    @Override
    public void insert(ReplyLike replyLike) {
        jdbcTemplate.update("insert into post (postId, userId) values (?,?)"
                , replyLike.getReplyId(), replyLike.getUserId());
    }

    @Override
    public void delete(ReplyLike replyLike) {
        jdbcTemplate.update("delete from postLike where postId = ? And userID = ?", replyLike.getReplyId(), replyLike.getUserId());
    }
}
