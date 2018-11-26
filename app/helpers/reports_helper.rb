module ReportsHelper
  def current_report
    if report[:report_id]
      @current_report ||= Report.find_by(id: report[:report_id])
    end
  end
end
