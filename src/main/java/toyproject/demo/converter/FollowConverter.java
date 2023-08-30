package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.FollowWithTokenDTO;
import toyproject.demo.domain.Follow;

@Service
public class FollowConverter implements Converter<FollowWithTokenDTO, Follow> {
    @Override
    public Follow convert(FollowWithTokenDTO source) {
        Follow follow = new Follow();
        follow.setFollowingUserId(source.getFollowingUserId());
        follow.setFollowedUserId(source.getFollowedUserId());
        follow.setDate(source.getDate());
        follow.setId(source.getId());
        follow.setFollowingUserRoot(source.getFollowingUserRoot());
        follow.setFollowedUserRoot(source.getFollowedUserRoot());
        return follow;
    }
}
