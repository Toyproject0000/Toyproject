package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
import toyproject.demo.domain.User;

@Service
public class UserConverter implements Converter<UserWithTokenDTO, User> {
    @Override
    public User convert(UserWithTokenDTO source) {
        User user = new User();
        user.setId(source.getId());
        user.setInfo(source.getInfo());
        user.setNickname(source.getNickname());
        user.setPassword(source.getPassword());
        user.setImgLocation(source.getImgLocation());
        user.setPhoneNumber(source.getPhoneNumber());
        user.setName(source.getName());
        user.setGender(source.getGender());
        user.setRoot(source.getRoot());
        user.setBirth(source.getBirth());
        return user;
    }
}
