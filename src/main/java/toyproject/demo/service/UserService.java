package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.User;
import toyproject.demo.repository.CategoryRepository;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;

    @Transactional
    public String join(User user){
        try {
            userRepository.insert(user);
            categoryRepository.insert(user.getId(), user.getRoot());
            return "ok";
        }
        catch (DuplicateKeyException e){
            log.error("error", e);
            if (e.getMessage().contains(user.getNickname())) {
                return "닉네임이 사용중입니다.";
            }
            return "이미 가입된 아이디입니다.";
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
    }

    public String duplicateNick(User user){
        List<User> users = userRepository.findNickname(user);
        if(users.size()!=0){
            return "사용중인 닉네임입니다.";
        }
        return "사용가능한 닉네임입니다.";
    }

    public List<ProfileViewDTO> findUser(String id, String root){
        List<ProfileViewDTO> result = userRepository.findUser(id, root);
        return result;
    }


    public String login(User user){
        List<User> findUser = userRepository.findById(user.getId(), user.getRoot());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getPassword().equals(user.getPassword())){
            return "비번 오류";
        }

        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }

    public String socialLogin(User user){
        List<User> findUser = userRepository.findById(user.getId(), user.getRoot());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getRoot().equals(user.getRoot())||findUser.get(0).getRoot().equals("local")){
            return "잘못된 접근입니다.";
        }

        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }


    public String edit(User user, String userId){
        try {
            userRepository.update(user, userId);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }

    public List<ProfileDTO> userProfile(String id, String root, String loginId, String loginRoot){
        return userRepository.userProfile(id, root, loginId, loginRoot);
    }

    public void delete(User user){
        userRepository.delete(user);
    }



}