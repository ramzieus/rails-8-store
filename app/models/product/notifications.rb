module Product::Notifications
    extend ActiveSupport::Concern

    # when you include a module in a class, any code inside the `included` block
    # runs as if it's part of that class.
    included do
        has_many :subscribers, dependent: :destroy
        after_update_commit :notify_subscribers, if: :back_in_stock?
    end

    def back_in_stock?
        inventory_count_previously_was == 0 && inventory_count > 0
    end

    def notify_subscribers
        subscribers.each do |subscriber|
            ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
        end
    end
end
