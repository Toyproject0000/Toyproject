package toyproject.demo.Controller;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;
import toyproject.demo.service.SmsService;
import toyproject.demo.service.UserService;

import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserControllerTest {

    User user = new User();
    @BeforeEach
    void beforeEach(){
        user.setId("test");
        user.setName("test");
        user.setPassword("test");
        user.setNickname("test");
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
        assertThat(login1).isEqualTo("ID 오류");

        User user2 = new User();
        user2.setId("test");
        user2.setPassword("test1");
        String login2 = userController.login(user2);
        assertThat(login2).isEqualTo("비번 오류");
    }
}