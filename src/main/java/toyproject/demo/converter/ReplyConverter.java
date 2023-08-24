package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.ReplyWithTokenDTO;
import toyproject.demo.domain.Reply;

@Service
public class ReplyConverter implements Converter<ReplyWithTokenDTO, Reply> {
    @Override
    public Reply convert(ReplyWithTokenDTO source) {
        Reply reply = new Reply();
        reply.setContents(source.getContents());
        reply.setId(source.getId());
        reply.setDate(source.getDate());
        reply.setPostId(source.getPostId());
        reply.setUserId(source.getUserId());
        return reply;
    }
}
