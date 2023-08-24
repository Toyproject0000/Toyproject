package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.ReportWithTokenDTO;
import toyproject.demo.domain.Report;

@Service
public class ReportConverter implements Converter<ReportWithTokenDTO, Report> {
    @Override
    public Report convert(ReportWithTokenDTO source) {
        Report report = new Report();
        report.setDate(source.getDate());
        report.setReason(source.getReason());
        report.setReportedPostId(source.getReportedPostId());
        report.setReportedUserId(source.getReportedUserId());
        report.setReportingUserId(source.getReportingUserId());
        return report;
    }
}
