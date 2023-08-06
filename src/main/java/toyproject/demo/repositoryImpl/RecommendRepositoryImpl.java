package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Post;
import toyproject.demo.repository.RecommendRepository;

import java.util.List;
@Repository
public class RecommendRepositoryImpl implements RecommendRepository {
    private final JdbcTemplate jdbcTemplate;

    public RecommendRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public String recommend(String userId) {
        return jdbcTemplate.update("select ");
    }
}
