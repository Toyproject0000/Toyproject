package toyproject.demo.Controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class UserControllerTest {

    User user = new User();
    @BeforeEach
    void beforeEach(){
        user.setId("test");
        user.setName("test");
        user.setPassword("test");
        user.setNickname("test");
        user.setPhoneNumber(123);
        user.setGender(true);
    }

    @Autowired private UserController userController;
    @Autowired private UserRepository userRepository;


    @Test
    void join() {
        userController.join(user);
        List<User> users = userRepository.findAll();
        assertThat(users.size()).isEqualTo(1);
    }

    @Test
    void login() {
        userController.join(user);
        String login = userController.login(user);

        assertThat(login).isEqualTo("ok");

        User user1 = new User();
        user1.setId("test1");
        user1.setPassword("test");
        String login1 = userController.login(user1);
        assertThat(login1).isEqualTo("id 오류");

        User user2 = new User();
        user2.setId("test");
        user2.setPassword("test1");
        String login2 = userController.login(user2);
        assertThat(login2).isEqualTo("비번 오류");
    }

    @Test
    void findId(){
        userController.join(user);

        String findId = userController.findId(user);

        assertThat(findId).isEqualTo("test");
    }

    @Test
    void findPassword(){
        userController.join(user);

        String password = userController.findPassword(user);

        assertThat(password).isEqualTo("test");
    }

    @Test
    void edit(){
        userController.join(user);
        user.setPassword("test1");

        userController.edit(user);
        String password = userController.findPassword(user);

        assertThat(password).isEqualTo("test1");
    }

    @Test
    void delete(){
        userController.join(user);
        userController.delete(user);

        String id = userController.findId(user);

        assertThat(id).isEqualTo("가입되어 있지않음");
    }

}