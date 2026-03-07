# BancardPaymentService
#
# Placeholder for Bancard vPOS 2.0 API integration.
# Bancard is Paraguay's primary payment gateway supporting credit/debit cards.
#
# Documentation: https://vpos.infonet.com.py
#
# Implementation steps:
#
# 1. Register at Bancard and obtain:
#    - public_key
#    - private_key
#    - commerce_id (merchant ID)
#
# 2. Configure credentials in Rails credentials:
#    rails credentials:edit
#    bancard:
#      public_key: xxx
#      private_key: xxx
#      commerce_id: xxx
#      environment: staging  # or production
#
# 3. Implement the following endpoints:
#
#    - single_buy: Initiate a one-time payment (for monthly plans or lifetime)
#      POST https://vpos.infonet.com.py/vpos/api/0.3/single_buy
#
#    - single_buy_confirm: Confirm payment after user completes on Bancard's form
#      POST https://vpos.infonet.com.py/vpos/api/0.3/single_buy/confirmations
#
#    - single_buy_rollback: Rollback a failed or cancelled payment
#      DELETE https://vpos.infonet.com.py/vpos/api/0.3/single_buy/rollback
#
# 4. For recurring payments (monthly subscriptions):
#    - cards_new: Register a card for recurring charges
#    - charge: Charge a registered card
#
# 5. Webhook handling:
#    Create a route POST /webhooks/bancard to receive payment confirmations
#
# Flow:
#   1. User clicks "Upgrade" -> we call single_buy to get a process_id
#   2. Redirect user to Bancard's payment form with the process_id
#   3. User completes payment on Bancard
#   4. Bancard redirects back to our return_url
#   5. We confirm the payment with single_buy_confirm
#   6. On success -> activate subscription
#

class BancardPaymentService
  STAGING_URL = "https://vpos.infonet.com.py/vpos/api/0.3"
  PRODUCTION_URL = "https://vpos.infonet.com.py/vpos/api/0.3"

  def initialize(user:, plan:, amount:, lifetime: false)
    @user = user
    @plan = plan
    @amount = amount
    @lifetime = lifetime
  end

  # Initiate a payment session with Bancard.
  # Returns a process_id to redirect the user to Bancard's payment form.
  def initiate_payment
    # TODO: Implement when Bancard credentials are available
    #
    # token = generate_token(shop_process_id, amount)
    # response = HTTP.post("#{base_url}/single_buy", json: {
    #   public_key: credentials[:public_key],
    #   operation: {
    #     token: token,
    #     shop_process_id: shop_process_id,
    #     amount: @amount.to_s,
    #     currency: "PYG",
    #     additional_data: "",
    #     description: "ContratoFácil - Plan #{@plan.capitalize}",
    #     return_url: return_url,
    #     cancel_url: cancel_url
    #   }
    # })
    #
    # response.parse["process_id"]
    raise NotImplementedError, "Bancard integration pending. Use manual payment flow."
  end

  # Confirm a completed payment.
  def confirm_payment(shop_process_id)
    # TODO: Implement
    raise NotImplementedError, "Bancard integration pending."
  end

  private

  def base_url
    # Rails.application.credentials.dig(:bancard, :environment) == "production" ? PRODUCTION_URL : STAGING_URL
    STAGING_URL
  end

  def credentials
    # Rails.application.credentials.bancard
    {}
  end

  def generate_token(shop_process_id, amount)
    # private_key = credentials[:private_key]
    # Digest::MD5.hexdigest("#{private_key}#{shop_process_id}#{amount}PYG")
    ""
  end
end
