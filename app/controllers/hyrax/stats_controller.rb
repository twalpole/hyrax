module Hyrax
  class StatsController < ApplicationController
    include Hyrax::SingularSubresourceController
    include Hyrax::Breadcrumbs

    before_action :build_breadcrumbs, only: [:work, :file]

    # TODO: New reporting features FlipFlop pattern:
    # Flipflop.enabled?(:analytics_redesign)

    def work
      @stats = Hyrax::WorkUsage.new(params[:id])
    end

    def file
      @stats = Hyrax::FileUsage.new(params[:id])
    end

    private

      def add_breadcrumb_for_controller
        add_breadcrumb I18n.t('hyrax.dashboard.my.works'), hyrax.my_works_path
      end

      def add_breadcrumb_for_action
        case action_name
        when 'file'.freeze
          add_breadcrumb I18n.t("hyrax.file_set.browse_view"), main_app.hyrax_file_set_path(params["id"])
        when 'work'.freeze
          add_breadcrumb @work.to_s, main_app.polymorphic_path(@work)
        end
      end
  end
end
