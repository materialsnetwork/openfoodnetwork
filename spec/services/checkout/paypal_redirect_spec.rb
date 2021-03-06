# frozen_string_literal: true

require 'spec_helper'

describe Checkout::PaypalRedirect do
  describe '#path' do
    let(:params) { { order: { order_id: "123" } } }

    let(:redirect) { Checkout::PaypalRedirect.new(params) }

    it "returns nil if payment_attributes are not provided" do
      expect(redirect.path).to be nil
    end

    describe "when payment_attributes are provided" do
      it "raises an error if payment method does not exist" do
        params[:order][:payments_attributes] = [{ payment_method_id: "123" }]

        expect { redirect.path }.to raise_error ActiveRecord::RecordNotFound
      end

      describe "when payment method provided exists" do
        before { params[:order][:payments_attributes] = [{ payment_method_id: payment_method.id }] }

        describe "and the payment method is not a paypal payment method" do
          let(:payment_method) { create(:payment_method) }

          it "returns nil" do
            expect(redirect.path).to be nil
          end
        end

        describe "and the payment method is a paypal method" do
          let(:distributor) { create(:distributor_enterprise) }
          let(:payment_method) do
            Spree::Gateway::PayPalExpress.create!(name: "PayPalExpress",
                                                  distributor_ids: [distributor.id])
          end

          it "returns the redirect path" do
            expect(redirect.path).to include payment_method.id.to_s
          end
        end
      end
    end
  end
end
