package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.PostWithTokenDTO;
import toyproject.demo.domain.Post;
@Service
public class PostConverter implements Converter<PostWithTokenDTO, Post> {
    @Override
    public Post convert(PostWithTokenDTO source) {
        Post post = new Post();
        post.setDisclosure(source.getDisclosure());
        post.setCategory(source.getCategory());
        post.setContents(source.getContents());
        post.setImgLocation(source.getImgLocation());
        post.setTitle(source.getTitle());
        post.setUserId(source.getUserId());
        post.setDate(source.getDate());
        post.setPossiblyReply(source.getPossiblyReply());
        post.setId(source.getId());
        post.setNickname(source.getNickname());
        post.setLikeCount(source.getLikeCount());
        post.setVisiblyLike(source.getVisiblyLike());
        return post;
    }
}
