class ReportJoinAutoController < ApplicationController
  def new
  end

  def destroy
    @rja = ReportJoinAuto.find(params[:rjaID])
    @reportID = @rja.report_id
    @rja.destroy
    respond_to do |format|
      format.html { redirect_to edit_report_path(@reportID), notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


end
