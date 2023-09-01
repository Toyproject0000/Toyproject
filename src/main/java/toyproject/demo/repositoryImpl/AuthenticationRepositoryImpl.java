package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AuthenticationRepositoryImpl {
    private final JdbcTemplate jdbcTemplate;

    public void insert(String id, String num){
        jdbcTemplate.update("insert into authentication (user_id, num)  values (?,?)", id, Integer.parseInt(num));
    }

    public Integer find(String id){
        return jdbcTemplate.queryForObject("SELECT num FROM authentication WHERE user_id = ? ORDER BY created_at DESC LIMIT 1;", Integer.class, id);
    }

    public void delete(String id){
        jdbcTemplate.update("delete from authentication where user_id = ?", id);
    }
}
