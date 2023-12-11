class AccessesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link, only: [:access_details, :access_counts]
    after_action :clear_flash, only: [:access_details]
  
    def index
        @link = Link.find(params[:link_id])
        @accesses = @link.accesses.order(created_at: :desc)
    end

    def access_details
        @accesses = @link.accesses.order(created_at: :desc)

        @accesses = @accesses.filter_by_ip(params[:ip]) if params[:ip].present?

        if params[:start_date].present? && params[:end_date].present?
            start_date = Date.parse(params[:start_date])
            end_date = Date.parse(params[:end_date])

            if start_date > end_date
            flash[:error] = 'La fecha de inicio debe ser menor o igual a la fecha de fin.'
            render 'access_details'
            return
            end

            @accesses = @accesses.filter_by_date_range(params[:start_date], params[:end_date])
        elsif params[:start_date].present? || params[:end_date].present?
            flash[:error] = 'Debes ingresar ambas fechas para el filtrado.'
            render 'access_details'
            return
        end
    end
    
    def access_counts
        # Obtener la zona horaria actual
        current_time_zone = Time.zone

        # Cambiar la zona horaria para la consulta
        Time.use_zone('UTC') do
            @accesses_by_day = @link.accesses.group_by_day { |a| a.created_at.in_time_zone(current_time_zone).to_date }.transform_values(&:count)
        end
    end

    private

      def set_link
        @link = current_user.links.find(params[:id])
      end

      def clear_flash
        flash[:error] = nil
      end
end
