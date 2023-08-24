package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.ReplyLikeWithTokenDTO;
import toyproject.demo.domain.ReplyLike;

@Service
public class ReplyLikeConverter implements Converter<ReplyLikeWithTokenDTO, ReplyLike> {

    @Override
    public ReplyLike convert(ReplyLikeWithTokenDTO source) {
        ReplyLike replyLike = new ReplyLike();
        replyLike.setReplyId(source.getReplyId());
        replyLike.setId(source.getId());
        replyLike.setUserId(source.getUserId());
        return replyLike;
    }
}
