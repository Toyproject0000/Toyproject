package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.PostLikeWithTokenDTO;
import toyproject.demo.domain.PostLike;

@Service
public class PostLikeConverter implements Converter<PostLikeWithTokenDTO, PostLike> {
    @Override
    public PostLike convert(PostLikeWithTokenDTO source) {
        PostLike postLike = new PostLike();
        postLike.setPostId(source.getPostId());
        postLike.setId(source.getId());
        postLike.setUserId(source.getUserId());
        postLike.setUserRoot(source.getUserRoot());
        return postLike;
    }
}
