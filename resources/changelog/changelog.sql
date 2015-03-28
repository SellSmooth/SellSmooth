CREATE TABLE client (id uuid NOT NULL, active bit(1) NOT NULL, last_activity TIMESTAMP WITHOUT time ZONE , ap_id varchar(255), address_information bigint , last_instore_barcode bigint DEFAULT '0', test_mode bit(1) DEFAULT b'0', contactable_by_referral_partner bit(1) NOT NULL DEFAULT b'0', sepa_registered bit(1) NOT NULL DEFAULT b'0', creation_date TIMESTAMP WITHOUT time ZONE , default_timezone varchar(255), default_language varchar(255), ALIAS varchar(255), master uuid , franchisor_id uuid , sugar_crm_id uuid , support_code varchar(10), TYPE varchar(255), PRIMARY KEY (id), CONSTRAINT CLIENT_MASTER
                     FOREIGN KEY (master) REFERENCES client (id) ON
                     DELETE NO ACTION ON
                     UPDATE NO ACTION);


CREATE TABLE address_information (id uuid NOT NULL , address_line1 varchar(255), address_line2 varchar(255), city varchar(255), company varchar(255), country varchar(255), department varchar(255), gln varchar(255), STATE varchar(255), tax_id varchar(255), zip_code varchar(255), PRIMARY KEY (id));


CREATE TABLE table_overview (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), x integer NOT NULL, y integer NOT NULL, client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK1BC733D99734C7E6
                             FOREIGN KEY (client) REFERENCES client (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE table_overview_tables (table_overview uuid NOT NULL, table_column integer , direction varchar(255), name varchar(255), table_row integer , x integer NOT NULL DEFAULT '0', y integer NOT NULL DEFAULT '0', TYPE varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT TABLE_OVERVIEW_TABLES_OVERVIEW
                                    FOREIGN KEY (table_overview) REFERENCES table_overview (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE supplier (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, additional_information varchar(255), contact_person_firstname varchar(255), contact_person_phone varchar(255), contact_person_email varchar(255), customer_number varchar(255), contact_telefax varchar(255), contact_website varchar(255), contact_person_salutation varchar(255), contact_person_surname varchar(255), contact_person_mobile varchar(255), contact_person_telefax varchar(255), contact_phone varchar(255), contact_email varchar(255), creditor_identifier varchar(255), order_phone varchar(255), order_email varchar(255), order_weekdays integer , order_time_from TIMESTAMP WITHOUT time ZONE , order_time_to TIMESTAMP WITHOUT time ZONE , delivery_weekdays integer , delivery_time integer , delayed_delivery_starting integer , shipper varchar(255), payment_currency uuid , payment_method varchar(255), bank varchar(255), rounting_code varchar(255), bic varchar(255), account_number varchar(255), iban varchar(255), address_information uuid , return_information uuid , number_value bigint DEFAULT '0', order_exchange_entry uuid , master_product uuid , deposit_product uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', external_id varchar(255), PRIMARY KEY (id), CONSTRAINT SUPPLIER_RETURN_INFORMATION
                       FOREIGN KEY (return_information) REFERENCES address_information (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE supplier_shipping_costs (supplier uuid NOT NULL, condition_text varchar(255)NOT NULL, price numeric NOT NULL, id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT FK6C409B9C408A2E1B
                                      FOREIGN KEY (supplier) REFERENCES supplier (id) ON
                                      DELETE NO ACTION ON
                                      UPDATE NO ACTION);


CREATE TABLE producer (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), service varchar(255), production_trigger varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', sub_producer uuid , PRIMARY KEY (id), CONSTRAINT FK58706C119734C7E6
                       FOREIGN KEY (client) REFERENCES client (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE price_group (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), net_prices bit(1) NOT NULL, client uuid NOT NULL, currency uuid , number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK2A8DBDFA9734C7E6
                          FOREIGN KEY (client) REFERENCES client (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE product (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, barcode varchar(255), base_price_max numeric , base_price_min numeric , discountable bit(1) NOT NULL, name varchar(255), price_changeable bit(1) NOT NULL, client uuid NOT NULL, alternative_sector uuid , commodity_group uuid , item_sequence uuid , producer uuid , sector uuid , ticket_validity_description uuid , track_inventory bit(1) DEFAULT b'0', requires_serial_number bit(1) DEFAULT b'0', purchase_price decimal(17,4) , base_price_unit varchar(255), packaging_quantity decimal(17,4) , number_value bigint DEFAULT '0', assortment uuid , active_assortment bit(1) , active_assortment_from TIMESTAMP WITHOUT time ZONE , preparation_product bit(1) NOT NULL DEFAULT b'0', image_id uuid , costs decimal(17,4) NOT NULL DEFAULT '0.0000', packaging bit(1) DEFAULT b'0', warranty_period bigint , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', suggestion_tag uuid , set_type integer NOT NULL DEFAULT '0', PRIMARY KEY (id), CONSTRAINT FKE87E2D2DA9D168F4
                      FOREIGN KEY (producer) REFERENCES producer (id) ON
                      DELETE NO ACTION ON
                      UPDATE NO ACTION);


CREATE TABLE subproduct_relation (id uuid NOT NULL, active bit(1) NOT NULL, amount numeric , product uuid , POSITION integer , PRIMARY KEY (id), CONSTRAINT FK14CD961E2C64CDE4
                                  FOREIGN KEY (product) REFERENCES product (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE subproduct_relation_prices (subproduct_relation uuid NOT NULL, price_group uuid , valid_from TIMESTAMP WITHOUT time ZONE , value numeric NOT NULL, organizational_unit uuid , product_code varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT SUBproduct_RELATION_PRICES_SUBproduct
                                         FOREIGN KEY (subproduct_relation) REFERENCES subproduct_relation (id) ON
                                         DELETE NO ACTION ON
                                         UPDATE NO ACTION);


CREATE TABLE sub_product_selection_prices (sub_product_selection bigint NOT NULL, price_group uuid , valid_from TIMESTAMP WITHOUT time ZONE , value numeric NOT NULL, organizational_unit uuid , id uuid NOT NULL , product_code varchar(255), PRIMARY KEY (id), CONSTRAINT SUB_product_SEL_PRICE_PG
                                           FOREIGN KEY (price_group) REFERENCES price_group (id) ON
                                           DELETE CASCADE ON
                                           UPDATE NO ACTION);


CREATE TABLE supplier_discounts (supplier uuid NOT NULL, DAY integer NOT NULL, percent_value numeric NOT NULL, id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT SUPPLIER_DISCOUNTS_SUPPLIER
                                 FOREIGN KEY (supplier) REFERENCES supplier (id) ON
                                 DELETE NO ACTION ON
                                 UPDATE NO ACTION);


CREATE TABLE referral_partner (id uuid NOT NULL, active bit(1) NOT NULL, company varchar(255), email varchar(255), firstname varchar(255), password_hash varchar(255), password_salt varchar(255), surname varchar(255), commission_percent numeric DEFAULT '10.00', last_payment TIMESTAMP WITHOUT time ZONE , ap_id varchar(255), PRIMARY KEY (id));


CREATE TABLE referral_partner_phones (referral_partner uuid , country_prefix varchar(255), number varchar(255), name varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT REFERRAL_PARTNER_PHONES_REFERRAL_PARTNER
                                      FOREIGN KEY (referral_partner) REFERENCES referral_partner (id) ON
                                      DELETE NO ACTION ON
                                      UPDATE NO ACTION);


CREATE TABLE payment_service_profile (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK40AAE23D9734C7E6
                                      FOREIGN KEY (client) REFERENCES client (id) ON
                                      DELETE NO ACTION ON
                                      UPDATE NO ACTION);


CREATE TABLE payment_service_profile_configurations (payment_service_profile uuid NOT NULL, merchant_key varchar(255), merchant_name varchar(255), merchant_site_id varchar(255), service_type integer , device_url varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT FKE75E547FA348720F
                                                     FOREIGN KEY (payment_service_profile) REFERENCES payment_service_profile (id) ON
                                                     DELETE NO ACTION ON
                                                     UPDATE NO ACTION);


CREATE TABLE event (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, number_value bigint , capacity bigint , duration integer NOT NULL, name varchar(255), LOCATION varchar(255), START TIMESTAMP WITHOUT time ZONE , client uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK73876BE29734C7E7
                    FOREIGN KEY (client) REFERENCES client (id) ON
                    DELETE NO ACTION ON
                    UPDATE NO ACTION);


CREATE TABLE event_categories (event uuid NOT NULL, name varchar(255), external_id varchar(255), product uuid , id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT FK6401B8BE9944X7E1
                               FOREIGN KEY (event) REFERENCES event (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE customer (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , birthday TIMESTAMP WITHOUT time ZONE , gender integer , zip_code varchar(255), client uuid NOT NULL, firstname varchar(255), lastname varchar(255), number varchar(255), number_value bigint DEFAULT '0', email varchar(255), address_line1 varchar(255), address_line2 varchar(255), STATE varchar(255), country varchar(255), city varchar(255), customer_group uuid , loyalty_reward_points numeric , phone varchar(255), sugar_crm_id uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', company varchar(255), PRIMARY KEY (id), CONSTRAINT FK80390B459734C7E6
                       FOREIGN KEY (client) REFERENCES client (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE customer_customer_informations (customer uuid NOT NULL, date TIMESTAMP WITHOUT time ZONE NOT NULL, text varchar(255)NOT NULL, creator_name varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT CUSTOMER_INFORMATIONS_CUSTOMER
                                             FOREIGN KEY (customer) REFERENCES customer (id) ON
                                             DELETE NO ACTION ON
                                             UPDATE NO ACTION);


CREATE TABLE customer_cards (customer uuid NOT NULL, number varchar(255), TYPE varchar(255), id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT FK7FD00DE977AB4EF3
                             FOREIGN KEY (customer) REFERENCES customer (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE supplier_item_price (id uuid NOT NULL , supplier uuid NOT NULL, order_number varchar(255)NOT NULL, box_size numeric NOT NULL, price decimal(19,4) NOT NULL, box_description varchar(255), PRIMARY KEY (id), CONSTRAINT SUPPLIER_ITEM_PRICE_SUPPLIER
                                  FOREIGN KEY (supplier) REFERENCES supplier (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE time_period (id uuid NOT NULL , years integer NOT NULL DEFAULT '0', months integer NOT NULL DEFAULT '0', weeks integer NOT NULL DEFAULT '0', days integer NOT NULL DEFAULT '0', hours integer NOT NULL DEFAULT '0', minutes integer NOT NULL DEFAULT '0', seconds integer NOT NULL DEFAULT '0', PRIMARY KEY (id));


CREATE TABLE dispatch_item (id uuid NOT NULL , order_quantity numeric , delivery_quantity numeric , order_quantity_unit varchar(255), delivery_quantity_unit varchar(255), product uuid , supplier_item_number varchar(255), buyer_item_number varchar(255), name varchar(255), color varchar(255), SIZE varchar(255), code varchar(255), batch varchar(255), part_delivery varchar(255), best_before_date TIMESTAMP WITHOUT time ZONE , container_quantity numeric , delivery_container numeric , PRIMARY KEY (id), CONSTRAINT DISPATCH_ITEM_product
                            FOREIGN KEY (product) REFERENCES product (id) ON
                            DELETE NO ACTION ON
                            UPDATE NO ACTION);


CREATE TABLE tag (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT TAG_CLIENT
                  FOREIGN KEY (client) REFERENCES client (id) ON
                  DELETE NO ACTION ON
                  UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger (id uuid NOT NULL , product_amount_greater uuid , product_amount_greater_quantity numeric , tag_amount_greater uuid , tag_amount_greater_quantity numeric , tag_value_greater uuid , tag_value_greater_quantity numeric , tag_amount_equal uuid , tag_amount_equal_quantity numeric , product_amount_equal uuid , product_amount_equal_quantity numeric , code varchar(255), min_total numeric , min_item_quantity numeric , valid_from TIMESTAMP WITHOUT time ZONE , valid_to TIMESTAMP WITHOUT time ZONE , time_from TIMESTAMP WITHOUT time ZONE , time_to TIMESTAMP WITHOUT time ZONE , PRIMARY KEY (id));


CREATE TABLE promotion_action_settings (id uuid NOT NULL , code varchar(255), print_text varchar(1024), print_type varchar(255), encash_daysafter_purchase_from integer , encash_daysafter_purchase_to integer , encash_type varchar(255), valid_from TIMESTAMP WITHOUT time ZONE , valid_to TIMESTAMP WITHOUT time ZONE , PRIMARY KEY (id));


CREATE TABLE product_product_texts (product uuid NOT NULL, TYPE varchar(255)NOT NULL, text text, LANGUAGE uuid , id uuid NOT NULL , PRIMARY KEY (id), CONSTRAINT FKBD0FG19BBB300502
                                    FOREIGN KEY (product) REFERENCES product (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE product_prices (product uuid NOT NULL, price_group uuid , valid_from TIMESTAMP WITHOUT time ZONE , value numeric NOT NULL, organizational_unit uuid , id uuid NOT NULL , product_code varchar(255), PRIMARY KEY (id), CONSTRAINT product_PRICES_PRICE_GROUP
                             FOREIGN KEY (price_group) REFERENCES price_group (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE account (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), TYPE integer , client uuid NOT NULL, number_value bigint DEFAULT '0', requires_serial_number bit(1) DEFAULT b'0', producer uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', denomination_input bit(1) NOT NULL DEFAULT b'0', PRIMARY KEY (id), CONSTRAINT FK410C1A569734C7E6
                      FOREIGN KEY (client) REFERENCES client (id) ON
                      DELETE NO ACTION ON
                      UPDATE NO ACTION);


CREATE TABLE api_application (id uuid NOT NULL, active bit(1) NOT NULL, name varchar(255), secret varchar(255), PRIMARY KEY (id));


CREATE TABLE api_access (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, api_key uuid , token varchar(255), app_id uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK_API_ACCESS_APP
                         FOREIGN KEY (app_id) REFERENCES api_application (id) ON
                         DELETE CASCADE);


CREATE TABLE info_text (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, text varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', TYPE varchar(255)NOT NULL DEFAULT 'RECEIPT', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK299D1D059734C7E6
                        FOREIGN KEY (client) REFERENCES client (id) ON
                        DELETE NO ACTION ON
                        UPDATE NO ACTION);


CREATE TABLE sub_product_selection (id uuid NOT NULL , tag uuid NOT NULL, quantity numeric NOT NULL DEFAULT '1.00', POSITION integer , PRIMARY KEY (id), CONSTRAINT SUB_product_SEL_TAG
                                    FOREIGN KEY (tag) REFERENCES tag (id) ON
                                    DELETE CASCADE ON
                                    UPDATE NO ACTION);


CREATE TABLE product_product_codes (product uuid NOT NULL, container_amount numeric NOT NULL, number varchar(255)NOT NULL, PRIMARY KEY (product,container_amount,number), CONSTRAINT FK891B1C0B408A2E1B
                                    FOREIGN KEY (product) REFERENCES product (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE product_info_texts (product uuid NOT NULL, info_texts uuid NOT NULL , PRIMARY KEY (product,info_texts), CONSTRAINT FKC07BE6CEF43F42C7
                                 FOREIGN KEY (info_texts) REFERENCES info_text (id) ON
                                 DELETE NO ACTION ON
                                 UPDATE NO ACTION);


CREATE TABLE product_sub_product_selections (product uuid NOT NULL, sub_product_selections uuid NOT NULL, PRIMARY KEY (product,sub_product_selections), CONSTRAINT product_SUB_product_SELECTIONS_SEL
                                             FOREIGN KEY (sub_product_selections) REFERENCES sub_product_selection (id) ON
                                             DELETE CASCADE ON
                                             UPDATE NO ACTION);


CREATE TABLE product_subproduct_relations (product uuid NOT NULL, subproduct_relations uuid NOT NULL, PRIMARY KEY (product,subproduct_relations), CONSTRAINT FK52193780913A4D50
                                           FOREIGN KEY (subproduct_relations) REFERENCES subproduct_relation (id) ON
                                           DELETE NO ACTION ON
                                           UPDATE NO ACTION);


CREATE TABLE product_supplier_item_prices (product uuid NOT NULL, supplier_item_prices uuid NOT NULL, PRIMARY KEY (product,supplier_item_prices), CONSTRAINT product_SUPPLIER_ITEM_PRICES_product
                                           FOREIGN KEY (product) REFERENCES product (id) ON
                                           DELETE NO ACTION ON
                                           UPDATE NO ACTION);


CREATE TABLE product_tags (product uuid NOT NULL, tags uuid NOT NULL, PRIMARY KEY (product,tags), CONSTRAINT product_TAGS_TAGS
                           FOREIGN KEY (tags) REFERENCES tag (id) ON
                           DELETE NO ACTION ON
                           UPDATE NO ACTION);


CREATE TABLE assortment (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', description varchar(512), last_clean_up TIMESTAMP WITHOUT time ZONE , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKA00F36F59734C7E6
                         FOREIGN KEY (client) REFERENCES client (id) ON
                         DELETE NO ACTION ON
                         UPDATE NO ACTION);


CREATE TABLE assortment_adjustment (id uuid NOT NULL, active bit(1) NOT NULL, client uuid NOT NULL, revision bigint , assortment uuid NOT NULL, sale_check_month_period bigint NOT NULL, sale_check_limit bigint NOT NULL, non_stock_mode varchar(255)NOT NULL, non_stock_transfer_assortment uuid , stock_mode varchar(255)NOT NULL, stock_transfer_assortment uuid , excecution_month_interval bigint , last_excecution TIMESTAMP WITHOUT time ZONE , next_excecution TIMESTAMP WITHOUT time ZONE , adjustment_criteria varchar(255)NOT NULL DEFAULT 'SALE_QUANTITY', marginal_income_check_month_period bigint NOT NULL DEFAULT '3', marginal_income_min_percent decimal(17,4) NOT NULL DEFAULT '2.0000', marginal_income_type varchar(255), booking_days bigint , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK9FGB1B7195E17D2C
                                    FOREIGN KEY (assortment) REFERENCES assortment (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE assortment_adjustment_exception_tags (assortment_adjustment uuid NOT NULL, exception_tags uuid NOT NULL, PRIMARY KEY (assortment_adjustment,exception_tags), CONSTRAINT FK5EGX1C7275E17D3C
                                                   FOREIGN KEY (exception_tags) REFERENCES tag (id) ON
                                                   DELETE NO ACTION ON
                                                   UPDATE NO ACTION);


CREATE TABLE assortment_adjustment_result (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, create_time TIMESTAMP WITHOUT time ZONE , booking_time TIMESTAMP WITHOUT time ZONE , modified_time TIMESTAMP WITHOUT time ZONE , create_user uuid , booking_user uuid , assortment_adjustment uuid NOT NULL, execution_time TIMESTAMP WITHOUT time ZONE , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C604
                                           FOREIGN KEY (assortment_adjustment) REFERENCES assortment_adjustment (id) ON
                                           DELETE NO ACTION ON
                                           UPDATE NO ACTION);


CREATE TABLE assortment_adjustment_result_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, assortment_adjustment_result uuid NOT NULL, product uuid NOT NULL, assortment_adjustment_mode varchar(255), transfer_assortment uuid , perform bit(1) NOT NULL, quantity numeric , marginal_income numeric , goods numeric , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C608
                                                FOREIGN KEY (assortment_adjustment_result) REFERENCES assortment_adjustment_result (id) ON
                                                DELETE NO ACTION ON
                                                UPDATE NO ACTION);


CREATE TABLE assortment_validity (id uuid NOT NULL , valid_from TIMESTAMP WITHOUT time ZONE , valid_to TIMESTAMP WITHOUT time ZONE , assortment uuid , PRIMARY KEY (id), CONSTRAINT ASSORTMENT_VALIDITY_ASSORTMENT
                                  FOREIGN KEY (assortment) REFERENCES assortment (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE attendance (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , category_name varchar(255), creation_time TIMESTAMP WITHOUT time ZONE , event uuid , expiration_time TIMESTAMP WITHOUT time ZONE , seats bigint , client uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK6421B8TE9944Y7E1
                         FOREIGN KEY (event) REFERENCES event (id) ON
                         DELETE NO ACTION ON
                         UPDATE NO ACTION);


CREATE TABLE customer_group (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', price_group uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK7A470459734C7E6
                             FOREIGN KEY (client) REFERENCES client (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE button_layout (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), x integer NOT NULL, y integer NOT NULL, client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKC94809EC9734C7E6
                            FOREIGN KEY (client) REFERENCES client (id) ON
                            DELETE NO ACTION ON
                            UPDATE NO ACTION);


CREATE TABLE pos_page_layout (id uuid NOT NULL , page varchar(255)NOT NULL, quick_button_layout uuid , tab_one uuid , tab_two uuid , tab_three uuid , PRIMARY KEY (id), CONSTRAINT POS_PAGE_LAYOUT_TABTWO
                              FOREIGN KEY (tab_two) REFERENCES button_layout (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE button_function_sequence (button uuid NOT NULL, account uuid , product uuid , button_layout uuid , customer_group uuid , info_text uuid , item_sequence uuid , macro varchar(255), payment_method uuid , TYPE integer , remote_report varchar(255), tag uuid , button_status varchar(255), id uuid NOT NULL , external_system_call uuid , PRIMARY KEY (id), CONSTRAINT FK7260EFFAFE1E0397
                                       FOREIGN KEY (customer_group) REFERENCES customer_group (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE button (id uuid NOT NULL, active bit(1) NOT NULL, bold_face bit(1) NOT NULL, color varchar(255), button_column integer , font_size integer NOT NULL, name varchar(255), button_row integer , x integer NOT NULL, y integer NOT NULL, PRIMARY KEY (id));


CREATE TABLE button_layout_buttons (button_layout uuid NOT NULL, buttons uuid NOT NULL, PRIMARY KEY (button_layout,buttons), CONSTRAINT FKB337C42ECA2DBB83
                                    FOREIGN KEY (buttons) REFERENCES button (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE cashier (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, firstname varchar(255), login_code varchar(255), surname varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', background_color integer , PRIMARY KEY (id), CONSTRAINT FK9F4E27809734C7E6
                      FOREIGN KEY (client) REFERENCES client (id) ON
                      DELETE NO ACTION ON
                      UPDATE NO ACTION);


CREATE TABLE cashier_permissions (cashier uuid NOT NULL, permissions varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (cashier,permissions), CONSTRAINT FK704E3A451E4817BB
                                  FOREIGN KEY (cashier) REFERENCES cashier (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE cashier_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, cancalled_items_amount numeric , cancalled_items_count numeric , cancalled_receipts_amount numeric , cancalled_receipts_count numeric , receipts_amount numeric , receipts_count numeric , returns_amount numeric , returns_count numeric , voided_receipts_amount numeric , voided_receipts_count numeric , cashier uuid , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C005
                              FOREIGN KEY (cashier) REFERENCES cashier (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE cloud_account_request (id uuid NOT NULL, active bit(1) NOT NULL, locked bit(1) NOT NULL, ap_id varchar(255), country varchar(255)NOT NULL, email varchar(255)NOT NULL, main_vertical varchar(255)NOT NULL, ref_id varchar(255), TEMPLATE uuid , zip_code varchar(255)NOT NULL, campaign_id varchar(255), firstname varchar(255), lastname varchar(255), company varchar(255), address varchar(255), city varchar(255), STATE varchar(255), telephone varchar(255), sugar_lead_id uuid , client uuid , managed bit(1) DEFAULT b'0', TYPE varchar(255), lead_source varchar(255), lead_source_description varchar(255), PRIMARY KEY (id));


CREATE TABLE commodity_group (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, parent_commodity_group uuid , commodity_group_key varchar(255), has_children bit(1) NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK9A7781969734C7E6
                              FOREIGN KEY (client) REFERENCES client (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE promotion_action_benefit (id uuid NOT NULL , filter_product uuid , filter_tag uuid , filter_commodity_group uuid , max_repeat_quantity numeric , calc_operand numeric , calc_operator varchar(255), TYPE varchar(255), PRIMARY KEY (id), CONSTRAINT promotion_ACTION_BENEFIT_FILTERTAG
                                       FOREIGN KEY (filter_tag) REFERENCES tag (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE commodity_group_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, commodity_group uuid NOT NULL, discount_amount numeric , items numeric , revenue numeric , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C007
                                      FOREIGN KEY (commodity_group) REFERENCES commodity_group (id) ON
                                      DELETE NO ACTION ON
                                      UPDATE NO ACTION);


CREATE TABLE promotion (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), number_value bigint DEFAULT '0', action uuid , redemption_count integer , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT promotion_CLIENT
                     FOREIGN KEY (client) REFERENCES client (id) ON
                     DELETE NO ACTION ON
                     UPDATE NO ACTION);


CREATE TABLE promotion_action (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), number_value bigint DEFAULT '0', name varchar(255), settings bigint , SYSTEM varchar(255)NOT NULL, benefit bigint , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT promotion_ACTION_CLIENT
                               FOREIGN KEY (client) REFERENCES client (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE promotion_action_triggers (promotion_action uuid NOT NULL , triggers bigint NOT NULL , PRIMARY KEY (promotion_action,triggers));


CREATE TABLE promotion_action_settings_orgs (promotion_action_settings uuid NOT NULL , orgs uuid NOT NULL , PRIMARY KEY (promotion_action_settings,orgs), CONSTRAINT promotion_ACTION_SETTINGS_ORGS_SETTINGS
                                             FOREIGN KEY (promotion_action_settings) REFERENCES promotion_action_settings (id) ON
                                             DELETE NO ACTION ON
                                             UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger_calendar_days (promotion_action_trigger uuid NOT NULL , calendar_days integer NOT NULL DEFAULT '0', PRIMARY KEY (promotion_action_trigger,calendar_days), CONSTRAINT promotion_ACTION_TRIGGER_CALENDAR_DAYS_TRIGGER
                                                     FOREIGN KEY (promotion_action_trigger) REFERENCES promotion_action_trigger (id) ON
                                                     DELETE NO ACTION ON
                                                     UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger_customer_groups (promotion_action_trigger uuid NOT NULL , customer_groups uuid NOT NULL , PRIMARY KEY (promotion_action_trigger,customer_groups), CONSTRAINT promotion_ACTION_TRIGGER_CUSTOMERGROUPS_TRIGGER
                                                       FOREIGN KEY (promotion_action_trigger) REFERENCES promotion_action_trigger (id) ON
                                                       DELETE NO ACTION ON
                                                       UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger_customers (promotion_action_trigger uuid NOT NULL , customers uuid NOT NULL , PRIMARY KEY (promotion_action_trigger,customers), CONSTRAINT promotion_ACTION_TRIGGER_CUSTOMERS_TRIGGER
                                                 FOREIGN KEY (promotion_action_trigger) REFERENCES promotion_action_trigger (id) ON
                                                 DELETE NO ACTION ON
                                                 UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger_organizational_units (promotion_action_trigger uuid NOT NULL, organizational_units uuid NOT NULL , PRIMARY KEY (promotion_action_trigger,organizational_units), CONSTRAINT promotion_ACTION_TRIGGER_ORGS_TRIGGER
                                                            FOREIGN KEY (promotion_action_trigger) REFERENCES promotion_action_trigger (id) ON
                                                            DELETE NO ACTION ON
                                                            UPDATE NO ACTION);


CREATE TABLE promotion_action_trigger_week_days (promotion_action_trigger uuid NOT NULL , week_days integer NOT NULL DEFAULT '0', PRIMARY KEY (promotion_action_trigger,week_days), CONSTRAINT promotion_ACTION_TRIGGER_WEEK_DAYS_TRIGGER
                                                 FOREIGN KEY (promotion_action_trigger) REFERENCES promotion_action_trigger (id) ON
                                                 DELETE NO ACTION ON
                                                 UPDATE NO ACTION);


CREATE TABLE currency (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, cent_name varchar(255), decimal_places integer NOT NULL, currency_key varchar(255), name varchar(255), symbol varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK421BC2F29734C7E6
                       FOREIGN KEY (client) REFERENCES client (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE currency_denominations (currency uuid NOT NULL, name varchar(255), nominal_value numeric NOT NULL DEFAULT '0.00', TYPE varchar(255)NOT NULL DEFAULT '', visible bit(1) NOT NULL, PRIMARY KEY (nominal_value,TYPE,currency), CONSTRAINT FK3E006EA13FCF2553
                                     FOREIGN KEY (currency) REFERENCES currency (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE currency_rates (currency uuid NOT NULL, valid_from TIMESTAMP WITHOUT time ZONE NOT NULL, factor decimal(16,5) NOT NULL, PRIMARY KEY (currency,valid_from), CONSTRAINT FK5C408I9C408A3E1B
                             FOREIGN KEY (currency) REFERENCES currency (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE customer_group_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, customer_group uuid NOT NULL, discount_amount numeric , items numeric , revenue numeric , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C009
                                     FOREIGN KEY (customer_group) REFERENCES customer_group (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE organizational_unit (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, parent uuid , address_information bigint , storage_space decimal(17,4) , sales_area decimal(17,4) , monday_open bit(1) NOT NULL DEFAULT b'0', tuesday_open bit(1) NOT NULL DEFAULT b'0', wednesday_open bit(1) , thursday_open bit(1) NOT NULL DEFAULT b'0', friday_open bit(1) NOT NULL DEFAULT b'0', saturday_open bit(1) NOT NULL DEFAULT b'0', sunday_open bit(1) NOT NULL DEFAULT b'0', monday_from TIMESTAMP WITHOUT time ZONE , tuesday_from TIMESTAMP WITHOUT time ZONE , wednesday_from TIMESTAMP WITHOUT time ZONE , thursday_from TIMESTAMP WITHOUT time ZONE , friday_from TIMESTAMP WITHOUT time ZONE , saturday_from TIMESTAMP WITHOUT time ZONE , sunday_from TIMESTAMP WITHOUT time ZONE , monday_to TIMESTAMP WITHOUT time ZONE , tuesday_to TIMESTAMP WITHOUT time ZONE , wednesday_to TIMESTAMP WITHOUT time ZONE , thursday_to TIMESTAMP WITHOUT time ZONE , friday_to TIMESTAMP WITHOUT time ZONE , saturday_to TIMESTAMP WITHOUT time ZONE , sunday_to TIMESTAMP WITHOUT time ZONE , centrality_index integer , monthly_operating_costs_rent decimal(17,4) , monthly_staff_costs decimal(17,4) , stretch_zone decimal(17,4) , viewing_zone decimal(17,4) , grip_zone decimal(17,4) , bend_zone decimal(17,4) , eh_number bigint , number_value bigint DEFAULT '0', has_children bit(1) NOT NULL, price_group uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', warehouse bit(1) DEFAULT b'0', economic_zone uuid , PRIMARY KEY (id), CONSTRAINT ORGANIZATIONAL_UNIT_PRICE_GROUP
                                  FOREIGN KEY (price_group) REFERENCES price_group (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE "user" (id uuid NOT NULL,
                             active bit(1) NOT NULL,
                                           revision bigint , number varchar(255)NOT NULL,
                                                                                email varchar(255),
                                                                                      firstname varchar(255),
                                                                                                password_hash varchar(255),
                                                                                                              password_salt varchar(255),
                                                                                                                            surname varchar(255),
                                                                                                                                    client uuid NOT NULL,
                                                                                                                                                ROLE uuid ,
                                                                                                                                                     origin_id uuid ,
                                                                                                                                                     requested_email varchar(255),
                                                                                                                                                                     email_change_count integer DEFAULT '0',
                                                                                                                                                                                                        created TIMESTAMP WITHOUT time ZONE ,
number_value bigint DEFAULT '0',
                            locale varchar(255),
                                   selected_org uuid ,
                                   origin_controlling varchar(255)NOT NULL DEFAULT 'NONE',
                                                                                   PRIMARY KEY (id), CONSTRAINT USER_SELECTED_ORG
                     FOREIGN KEY (selected_org) REFERENCES organizational_unit (id) ON
                     DELETE NO ACTION ON
                     UPDATE NO ACTION);


CREATE TABLE dashboard_entry (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, origin_controlling varchar(255), "user" uuid , entry_type varchar(255), entry_column integer , entry_index integer , PRIMARY KEY (id), CONSTRAINT DASHBOARD_ENTRY_USER
                              FOREIGN KEY ("user") REFERENCES "user" (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE data_exchange_entry (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, exchange_interface varchar(255)NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT DATA_EXCHANGE_ENTRY_CLIENT
                                  FOREIGN KEY (client) REFERENCES client (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE data_exchange_entry_configs (data_exchange_entry uuid NOT NULL , configs varchar(255), configs_key varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (data_exchange_entry,configs_key));


CREATE TABLE data_storage_change_log (id uuid NOT NULL, active bit(1) NOT NULL, client uuid NOT NULL, new_revision bigint , previous_revision bigint , entity_id uuid , entity_class varchar(255), new_value varchar(255), previous_value varchar(255), change_time TIMESTAMP WITHOUT time ZONE , protocol uuid , TYPE varchar(255), "user" uuid , PRIMARY KEY (id), CONSTRAINT DATA_STORAGE_CHANGE_LOG_USER
                                      FOREIGN KEY ("user") REFERENCES "user" (id) ON
                                      DELETE NO ACTION ON
                                      UPDATE NO ACTION);


CREATE TABLE data_storage_protocol (id uuid NOT NULL, active bit(1) NOT NULL, client uuid NOT NULL, start_revision bigint , end_revision bigint , start_time TIMESTAMP WITHOUT time ZONE , finish_time TIMESTAMP WITHOUT time ZONE , TYPE varchar(255), "user" uuid , PRIMARY KEY (id), CONSTRAINT DATA_STORAGE_PROTOCOL_USER
                                    FOREIGN KEY ("user") REFERENCES "user" (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE device_configuration (id uuid NOT NULL, active bit(1) NOT NULL, baud_rate varchar(255), device integer , init_command varchar(255), port varchar(255), port_parameter varchar(255), default_device bit(1) , PRIMARY KEY (id));


CREATE TABLE device_configuration_producers (device_configuration uuid NOT NULL, producers uuid NOT NULL, PRIMARY KEY (device_configuration,producers), CONSTRAINT FKCCE5E3D8A6F3BC83
                                             FOREIGN KEY (producers) REFERENCES producer (id) ON
                                             DELETE NO ACTION ON
                                             UPDATE NO ACTION);


CREATE TABLE device_configuration_settings (device_configuration uuid NOT NULL, settings varchar(255), settings_key varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (device_configuration,settings_key), CONSTRAINT FK5E24888C1FC014EE
                                            FOREIGN KEY (device_configuration) REFERENCES device_configuration (id) ON
                                            DELETE NO ACTION ON
                                            UPDATE NO ACTION);


CREATE TABLE device_profile (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK3F282FA39734C7E6
                             FOREIGN KEY (client) REFERENCES client (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE device_profile_configurations (device_profile uuid NOT NULL, configurations uuid NOT NULL, PRIMARY KEY (device_profile,configurations), CONSTRAINT FK3F1BCE59DF824D75
                                            FOREIGN KEY (configurations) REFERENCES device_configuration (id) ON
                                            DELETE NO ACTION ON
                                            UPDATE NO ACTION);


CREATE TABLE pos (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, distributor_code varchar(255), friendsbonus_identification varchar(255), friendsbonus_secret varchar(255), name varchar(255), secret varchar(255), system_hash varchar(255), client uuid NOT NULL, default_customer_group uuid , default_payment_method uuid , friendsbonus_customer_group uuid , layout_configuration uuid , organizational_unit uuid , table_overview uuid , warehouse uuid , number_value bigint DEFAULT '0', LANGUAGE uuid , bloyal_device_key varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', last_receipt_number varchar(255), lastzcount bigint , pos_profile uuid , PRIMARY KEY (id), CONSTRAINT POS_WAREHOUSE
                  FOREIGN KEY (warehouse) REFERENCES organizational_unit (id) ON
                  DELETE NO ACTION ON
                  UPDATE NO ACTION);


CREATE TABLE device_configuration_port_parameter_map (device_configuration uuid NOT NULL, port_parameter_map varchar(255), port_parameter_map_key uuid NOT NULL, PRIMARY KEY (device_configuration,port_parameter_map_key), CONSTRAINT FK_DEVICE_CONFIG_PPM_POS
                                                      FOREIGN KEY (port_parameter_map_key) REFERENCES pos (id) ON
                                                      DELETE NO ACTION ON
                                                      UPDATE NO ACTION);


CREATE TABLE dispatch_notification (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, buyer_information uuid , delivery_address_information bigint , final_recipient_information bigint , supplier_information bigint , transport_service_provider_information uuid , invoice_recipient_information bigint , booking_time TIMESTAMP WITHOUT time ZONE , booked_by uuid , created_by uuid , create_time TIMESTAMP WITHOUT time ZONE NOT NULL, supplier uuid , SOURCE uuid , target uuid , order_id uuid , delivery_date TIMESTAMP WITHOUT time ZONE , shipping_date TIMESTAMP WITHOUT time ZONE , number varchar(255), description varchar(255), number_value bigint DEFAULT '0', customer uuid , pos uuid , positions integer DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT DISPATCH_NOTIFICATION_TRANSPORT_SERVICE_PROVIDER_INFORMATION
                                    FOREIGN KEY (transport_service_provider_information) REFERENCES address_information (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE dispatch_container (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, dispatch_position integer , packaging varchar(255), shipping_unit_numer varchar(255), piece_of varchar(255), gross_volume numeric , volume_unit varchar(255), gross_weight numeric , weight_unit varchar(255), box_pieces varchar(255), box_piece_type varchar(255), dispatch_notification uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT DISPATCH_CONTAINER_DISPATCH_NOTIFICATION
                                 FOREIGN KEY (dispatch_notification) REFERENCES dispatch_notification (id) ON
                                 DELETE NO ACTION ON
                                 UPDATE NO ACTION);


CREATE TABLE dispatch_container_items (dispatch_container uuid NOT NULL , items uuid NOT NULL, PRIMARY KEY (dispatch_container,items), CONSTRAINT DISPATCH_CONTAINER_ITEMS_ITEMS
                                       FOREIGN KEY (items) REFERENCES dispatch_item (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE economic_zone (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK2A3EA46D9734C7E6
                            FOREIGN KEY (client) REFERENCES client (id) ON
                            DELETE NO ACTION ON
                            UPDATE NO ACTION);


CREATE TABLE end_of_day_statement (id uuid NOT NULL, active bit(1) NOT NULL, client uuid NOT NULL, revision bigint , finish_time TIMESTAMP WITHOUT time ZONE , printed_page_content text, printed_page_type varchar(255), receipt_count bigint , zcount bigint , pos uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C014
                                   FOREIGN KEY (pos) REFERENCES pos (id) ON
                                   DELETE NO ACTION ON
                                   UPDATE NO ACTION);


CREATE TABLE receipt (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, z_count bigint , create_time TIMESTAMP WITHOUT time ZONE , finish_time TIMESTAMP WITHOUT time ZONE , gross_total_amount numeric , modified_time TIMESTAMP WITHOUT time ZONE , net_total_amount numeric , order_number varchar(255), tax_amount numeric , voided bit(1) NOT NULL, client uuid NOT NULL, cashier uuid , currency uuid , customer uuid , customer_group uuid , pos uuid , price_group uuid , number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', receipt_discount_amount numeric NOT NULL DEFAULT '0.00', receipt_discount_gross_amount numeric NOT NULL DEFAULT '0.00', receipt_discount_net_amount numeric NOT NULL DEFAULT '0.00', gross_revenue_amount numeric , net_revenue_amount numeric , PRIMARY KEY (id), CONSTRAINT FKAE33812BFE1E0397
                      FOREIGN KEY (customer_group) REFERENCES customer_group (id) ON
                      DELETE NO ACTION ON
                      UPDATE NO ACTION);


CREATE TABLE account_transaction (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , amount numeric , booking_time TIMESTAMP WITHOUT time ZONE , description varchar(255), receipt_index integer NOT NULL, client uuid NOT NULL, account uuid , cashier uuid , pos uuid , receipt uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK5757017E0FFA768
                                  FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE account_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, account uuid NOT NULL, amount numeric , transactions numeric , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C003
                              FOREIGN KEY (account) REFERENCES account (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE account_transaction_info_texts (account_transaction uuid NOT NULL, info_texts varchar(255), info_texts_key integer NOT NULL DEFAULT '0', PRIMARY KEY (account_transaction,info_texts_key), CONSTRAINT ACCOUNT_TRANSACTION_INFO_TEXTS_ACCOUNT_TRANSACTION
                                             FOREIGN KEY (account_transaction) REFERENCES account_transaction (id) ON
                                             DELETE NO ACTION ON
                                             UPDATE NO ACTION);


CREATE TABLE entry_gate (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKB6A7E6EB9734C7E6
                         FOREIGN KEY (client) REFERENCES client (id) ON
                         DELETE NO ACTION ON
                         UPDATE NO ACTION);


CREATE TABLE external_system_call (id uuid NOT NULL, active bit(1) NOT NULL, pos_id uuid NOT NULL, revision bigint NOT NULL, name varchar(255), number varchar(255), number_value bigint DEFAULT '0', client uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', display_url varchar(255), display_url_post bit(1) NOT NULL, system_url varchar(255), login varchar(64), password varchar(64), connect_timeout_millis integer , request_timeout_millis integer , PRIMARY KEY (id));


CREATE TABLE franchise_product_widget (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, origin_controlling varchar(255), franchise_product_widget_entry varchar(255)NOT NULL, PRIMARY KEY (id));


CREATE TABLE franchise_product_widget_tags (franchise_product_widget uuid NOT NULL, tags uuid NOT NULL);


CREATE TABLE franchise_relationship (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), number_value bigint DEFAULT '0', name varchar(255), franchisee uuid NOT NULL, created_on TIMESTAMP WITHOUT time ZONE NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', purchase_price_group uuid NOT NULL, selling_price_group uuid NOT NULL, assortment uuid , LANGUAGE uuid , PRIMARY KEY (id), CONSTRAINT FRANCHISE_RELATIONSHIP_SELLING_PRICE_GROUP
                                     FOREIGN KEY (selling_price_group) REFERENCES price_group (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE franchise_relationship_request (id uuid NOT NULL, active bit(1) NOT NULL, locked bit(1) NOT NULL, franchisor uuid NOT NULL, franchisee uuid NOT NULL, created_on TIMESTAMP WITHOUT time ZONE NOT NULL, franchisee_name varchar(255), PRIMARY KEY (id));


CREATE TABLE image (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, create_time TIMESTAMP WITHOUT time ZONE , number varchar(255), number_value bigint DEFAULT '0', TYPE varchar(255), DATA varchar(1024), black_and_white bit(1) , usage_type varchar(255)NOT NULL DEFAULT 'product', name varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT IMAGE_CLIENT
                    FOREIGN KEY (client) REFERENCES client (id) ON
                    DELETE NO ACTION ON
                    UPDATE NO ACTION);


CREATE TABLE inventory_process (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, create_time TIMESTAMP WITHOUT time ZONE , number varchar(255), number_value bigint DEFAULT '0', description varchar(255), "user" uuid , inventory_procedure varchar(255), process_time TIMESTAMP WITHOUT time ZONE , one_commodity_group_per_list bit(1) DEFAULT b'0', max_products_per_list integer DEFAULT '0', automatic_booking bit(1) DEFAULT b'0', automatic_booking_days integer DEFAULT '0', monday_inventory bit(1) DEFAULT b'0', tuesday_inventory bit(1) DEFAULT b'0', wednesday_inventory bit(1) DEFAULT b'0', thursday_inventory bit(1) DEFAULT b'0', friday_inventory bit(1) DEFAULT b'0', saturday_inventory bit(1) DEFAULT b'0', sunday_inventory bit(1) DEFAULT b'0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKBD0FB18BBB100002
                                FOREIGN KEY ("user") REFERENCES "user" (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE inventory_process_organizational_units (inventory_process uuid NOT NULL, organizational_units uuid NOT NULL, PRIMARY KEY (inventory_process,organizational_units), CONSTRAINT FKBD0FB18BBB100004
                                                     FOREIGN KEY (organizational_units) REFERENCES organizational_unit (id) ON
                                                     DELETE NO ACTION ON
                                                     UPDATE NO ACTION);


CREATE TABLE inventory_receipt (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, pos uuid , cashier uuid , organizational_unit uuid , create_time TIMESTAMP WITHOUT time ZONE , modified_time TIMESTAMP WITHOUT time ZONE , finish_time TIMESTAMP WITHOUT time ZONE , number varchar(255), booking_time TIMESTAMP WITHOUT time ZONE , description varchar(255), "user" uuid , number_value bigint DEFAULT '0', inventory_process uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT INVENTORY_RECEIPT_USER
                                FOREIGN KEY ("user") REFERENCES "user" (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE inventory_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, nominal_goods numeric , actual_goods numeric , product uuid , receipt uuid , difference_reason varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT INVENTORY_ITEM_RECEIPT
                             FOREIGN KEY (receipt) REFERENCES inventory_receipt (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE item_sequence (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK141D79169734C7E6
                            FOREIGN KEY (client) REFERENCES client (id) ON
                            DELETE NO ACTION ON
                            UPDATE NO ACTION);


CREATE TABLE LANGUAGE (id uuid NOT NULL,
                               active bit(1) NOT NULL,
                                             revision bigint , client uuid NOT NULL, number varchar(255),
                                                                                            number_value bigint DEFAULT '0',
                                                                                                                        name varchar(255),
                                                                                                                             iso_code varchar(255),
                                                                                                                                      origin_controlling varchar(255)NOT NULL DEFAULT 'NONE',
                                                                                                                                                                                      PRIMARY KEY (id), CONSTRAINT LANGUAGE_CLIENT
                       FOREIGN KEY (client) REFERENCES client (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE login_ticket (id uuid NOT NULL, active bit(1) NOT NULL, hash varchar(255)NOT NULL, PRIMARY KEY (id));


CREATE TABLE navigation_entry (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, "user" uuid , entry_type varchar(255), entry_category varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT NAVIGATION_ENTRY_USER
                               FOREIGN KEY ("user") REFERENCES "user" (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE order_cycle (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, create_time TIMESTAMP WITHOUT time ZONE , number varchar(255), number_value bigint DEFAULT '0', name varchar(255), order_template uuid , start_date TIMESTAMP WITHOUT time ZONE , interval_period uuid , create_order_time uuid , pos_order_modification_time uuid , order_finalization_time uuid , import_dispatch_notification_time uuid , dispatch_notification_distribution_time uuid , stock_receipt_finalization_time uuid , create_stock_return_time uuid , finalize_stock_return_time uuid , mondays bit(1) NOT NULL DEFAULT b'1', tuesdays bit(1) NOT NULL DEFAULT b'1', wednesdays bit(1) NOT NULL DEFAULT b'1', thursdays bit(1) NOT NULL DEFAULT b'1', fridays bit(1) NOT NULL DEFAULT b'1', saturdays bit(1) NOT NULL DEFAULT b'1', sundays bit(1) NOT NULL DEFAULT b'1', dispatch_cycle bit(1) NOT NULL DEFAULT b'1', stock_return_cycle bit(1) NOT NULL DEFAULT b'1', optimize_template bit(1) NOT NULL DEFAULT b'0', last_order_creation TIMESTAMP WITHOUT time ZONE , "user" uuid , running bit(1) NOT NULL DEFAULT b'1', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT ORDER_CYCLE_STOCK_RECEIPT_FINALIZATION_TIME
                          FOREIGN KEY (stock_receipt_finalization_time) REFERENCES time_period (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE organizational_unit_ordering_sources (organizational_unit uuid NOT NULL, ordering_sources uuid NOT NULL, PRIMARY KEY (organizational_unit,ordering_sources), CONSTRAINT FK78902AF3408A2E1B
                                                   FOREIGN KEY (organizational_unit) REFERENCES organizational_unit (id) ON
                                                   DELETE NO ACTION ON
                                                   UPDATE NO ACTION);


CREATE TABLE organizational_unit_assortment_validities (organizational_unit uuid NOT NULL, id integer NOT NULL , assortment_validities bigint , PRIMARY KEY (id), CONSTRAINT FK6C528B9H408A2E1B
                                                        FOREIGN KEY (organizational_unit) REFERENCES organizational_unit (id) ON
                                                        DELETE NO ACTION ON
                                                        UPDATE NO ACTION);


CREATE TABLE product_listed_orgs (product uuid NOT NULL, listed_orgs uuid NOT NULL, PRIMARY KEY (product,listed_orgs), CONSTRAINT product_LISTED_ORGS_ORGANIZATIONAL_UNIT
                                  FOREIGN KEY (listed_orgs) REFERENCES organizational_unit (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE payment_method (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, allowed_balance_difference numeric , balance bit(1) NOT NULL, cash_due bit(1) NOT NULL, name varchar(255), service_parameter varchar(255), service_processing_mode integer , service_type integer , client uuid NOT NULL, currency uuid , use_cash_drawer bit(1) NOT NULL, denominated_balance bit(1) DEFAULT b'0', number_value bigint DEFAULT '0', no_signature_approval_limit numeric , auto_finalize_transactions bit(1) NOT NULL DEFAULT b'1', transaction_receipts integer NOT NULL DEFAULT '0', receipt_print_copies integer DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', force_print bit(1) NOT NULL DEFAULT b'0', force_customer_number bit(1) NOT NULL DEFAULT b'0', PRIMARY KEY (id), CONSTRAINT FKD91D9B699734C7E6
                             FOREIGN KEY (client) REFERENCES client (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE payment_method_receipt_info_texts (payment_method uuid NOT NULL, receipt_info_texts uuid NOT NULL, PRIMARY KEY (payment_method,receipt_info_texts), CONSTRAINT FKC987F712F43F42C7
                                                FOREIGN KEY (receipt_info_texts) REFERENCES info_text (id) ON
                                                DELETE NO ACTION ON
                                                UPDATE NO ACTION);


CREATE TABLE payment (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , amount numeric , cancel_transaction_id varchar(255), credit numeric , input_amount numeric , receipt_index integer NOT NULL, rounding_error numeric , transaction_id varchar(255), transaction_time TIMESTAMP WITHOUT time ZONE , transaction_token varchar(255), client uuid NOT NULL, cashier uuid , currency uuid , payment_method uuid , pos uuid , receipt uuid , transport_key varchar(255), card_holder varchar(255), card_number varchar(255), pre_auth_amount numeric , post_auth_amount numeric , finalized bit(1) NOT NULL DEFAULT b'1', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKE25F721DE0FFA768
                      FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                      DELETE NO ACTION ON
                      UPDATE NO ACTION);


CREATE TABLE payment_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, payment_method uuid NOT NULL, expected_amount numeric , actual_amount numeric , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C011
                              FOREIGN KEY (payment_method) REFERENCES payment_method (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE pos_balance_item (id uuid NOT NULL , payment_method uuid , denomination_type varchar(255), quantity numeric , nominal_value numeric , item_total numeric , PRIMARY KEY (id), CONSTRAINT POS_BALANCE_ITEM_PAYMENT_METHOD
                               FOREIGN KEY (payment_method) REFERENCES payment_method (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE pos_balance_item_summary (id uuid NOT NULL , payment_method uuid , actual_item_total numeric , expected_item_total numeric , absolute_difference numeric , PRIMARY KEY (id), CONSTRAINT POS_BALANCE_ITEM_SUMMARY_PAYMENT_METHOD
                                       FOREIGN KEY (payment_method) REFERENCES payment_method (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE pos_balance (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , actual_total numeric , expected_total numeric , client uuid NOT NULL, pos uuid , cashier uuid , balance_attempts integer , create_time TIMESTAMP WITHOUT time ZONE , finish_time TIMESTAMP WITHOUT time ZONE , z_count bigint DEFAULT '-1', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT POS_BALANCE_POS
                          FOREIGN KEY (pos) REFERENCES pos (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE pos_balance_item_summaries (pos_balance uuid NOT NULL , item_summaries uuid NOT NULL, PRIMARY KEY (pos_balance,item_summaries), CONSTRAINT POS_BALANCE_ITEM_SUMMARIES
                                         FOREIGN KEY (item_summaries) REFERENCES pos_balance_item_summary (id) ON
                                         DELETE NO ACTION ON
                                         UPDATE NO ACTION);


CREATE TABLE pos_balance_items (pos_balance uuid NOT NULL , items uuid NOT NULL, PRIMARY KEY (pos_balance,items), CONSTRAINT POS_BALANCE_ITEMS
                                FOREIGN KEY (items) REFERENCES pos_balance_item (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE pos_page_layout_configuration (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), quick_button_mode bit(1) NOT NULL, client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK41F485FD9734C7E6
                                            FOREIGN KEY (client) REFERENCES client (id) ON
                                            DELETE NO ACTION ON
                                            UPDATE NO ACTION);


CREATE TABLE pos_page_layout_configuration_page_layouts (pos_page_layout_configuration uuid NOT NULL, page_layouts bigint NOT NULL, PRIMARY KEY (pos_page_layout_configuration,page_layouts), CONSTRAINT POS_PAGE_LAYOUT_CONFIGURATION_LAYOUTS_LAYOUTCONF
                                                         FOREIGN KEY (pos_page_layout_configuration) REFERENCES pos_page_layout_configuration (id) ON
                                                         DELETE NO ACTION ON
                                                         UPDATE NO ACTION);


CREATE TABLE pos_print_footers (pos uuid NOT NULL, print_footers varchar(255), print_footers_key integer NOT NULL DEFAULT '0', PRIMARY KEY (pos,print_footers_key), CONSTRAINT FK3AE6F8F641C3DB
                                FOREIGN KEY (pos) REFERENCES pos (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE pos_print_headers (pos uuid NOT NULL, print_headers varchar(255), print_headers_key integer NOT NULL DEFAULT '0', PRIMARY KEY (pos,print_headers_key), CONSTRAINT FK92D66A4441C3DB
                                FOREIGN KEY (pos) REFERENCES pos (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE pos_receipt_info_texts (pos uuid NOT NULL, receipt_info_texts uuid NOT NULL, PRIMARY KEY (pos,receipt_info_texts), CONSTRAINT FK32C2122CF43F42C7
                                     FOREIGN KEY (receipt_info_texts) REFERENCES info_text (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE receipt_layout_configuration (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, name varchar(255), number varchar(255), item_grouping varchar(255), footer_logo_number integer , header_logo_number integer , show_product_numbers bit(1) , show_receipt_number_barcode bit(1) , show_reduced_receipt_information bit(1) , show_removed_items bit(1) , number_value bigint DEFAULT '0', header_image_id uuid , footer_image_id uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT RECEIPT_LAYOUT_CONFIGURATION_CLIENT
                                           FOREIGN KEY (client) REFERENCES client (id) ON
                                           DELETE NO ACTION ON
                                           UPDATE NO ACTION);


CREATE TABLE pos_profile (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), name varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', number_value bigint DEFAULT '0', auto_logout_delay integer NOT NULL, auto_receipt_print bit(1) NOT NULL, customer_display_offline_text varchar(255), customer_display_online_text varchar(255), force_closed_drawer bit(1) NOT NULL, max_balance_attempts integer NOT NULL, order_number_required bit(1) NOT NULL, payment_service_profile uuid , device_profile uuid , table_service_interval integer , receipt_layout_configuration uuid , automatic_end_of_day_interval_str varchar(255), cent_input bit(1) NOT NULL DEFAULT b'0', require_payment_amount_input bit(1) NOT NULL DEFAULT b'0', kiosk_mode bit(1) NOT NULL DEFAULT b'1', automatic_payment_finalization bit(1) , auto_reset_quick_access_pad bit(1) , easy_repeat_product_enabled bit(1) NOT NULL DEFAULT b'0', PRIMARY KEY (id), CONSTRAINT POS_PROFILE_RECEIPT_LAYOUT_CONFIGURATION
                          FOREIGN KEY (receipt_layout_configuration) REFERENCES receipt_layout_configuration (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE pos_profile_external_system_calls_on_book_receipt (pos_profile uuid NOT NULL, external_system_calls_on_book_receipt uuid NOT NULL, CONSTRAINT POS_PROFILE_EXTERNAL_SYSTEM_CALLS_ON_BOOK_RECEIPT_PROFILE
                                                                FOREIGN KEY (pos_profile) REFERENCES pos_profile (id) ON
                                                                DELETE NO ACTION ON
                                                                UPDATE NO ACTION);


CREATE TABLE pos_profile_external_system_calls_on_reject_receipt (pos_profile uuid NOT NULL, external_system_calls_on_reject_receipt uuid NOT NULL, CONSTRAINT POS_PROFILE_EXTERNAL_SYSTEM_CALLS_ON_REJECT_RECEIPT_PROFILE
                                                                  FOREIGN KEY (pos_profile) REFERENCES pos_profile (id) ON
                                                                  DELETE NO ACTION ON
                                                                  UPDATE NO ACTION);


CREATE TABLE pos_profile_external_system_calls_on_total_receipt (pos_profile uuid NOT NULL, external_system_calls_on_total_receipt uuid NOT NULL, CONSTRAINT POS_PROFILE_EXTERNAL_SYSTEM_CALLS_ON_TOTAL_RECEIPT_PROFILE
                                                                 FOREIGN KEY (pos_profile) REFERENCES pos_profile (id) ON
                                                                 DELETE NO ACTION ON
                                                                 UPDATE NO ACTION);


CREATE TABLE pos_profile_external_system_calls_on_void_receipt (pos_profile uuid NOT NULL, external_system_calls_on_void_receipt uuid NOT NULL, CONSTRAINT POS_PROFILE_EXTERNAL_SYSTEM_CALLS_ON_VOID_RECEIPT_PROFILE
                                                                FOREIGN KEY (pos_profile) REFERENCES pos_profile (id) ON
                                                                DELETE NO ACTION ON
                                                                UPDATE NO ACTION);


CREATE TABLE prepaid_card (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), value numeric , number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT PREPAID_CARD_CLIENT
                           FOREIGN KEY (client) REFERENCES client (id) ON
                           DELETE NO ACTION ON
                           UPDATE NO ACTION);


CREATE TABLE prepaid_card_transaction (id uuid NOT NULL, active bit(1) NOT NULL, voided bit(1) NOT NULL, revision bigint , client uuid NOT NULL, pos uuid , cashier uuid , account uuid , number varchar(255), amount numeric , booking_time TIMESTAMP WITHOUT time ZONE , COMMENT varchar(255), receipt_number varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT PREPAID_CARD_TRANSACTION_POS
                                       FOREIGN KEY (pos) REFERENCES pos (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE price_rule (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, minimum_amount numeric , name varchar(255), price_operand numeric , price_operator varchar(255), client uuid NOT NULL, product uuid , assortment uuid , commodity_group uuid , customer_group uuid , price_group uuid , interval_parameter integer , interval_type varchar(255), valid_to TIMESTAMP WITHOUT time ZONE , valid_from TIMESTAMP WITHOUT time ZONE , time_to TIMESTAMP WITHOUT time ZONE , time_from TIMESTAMP WITHOUT time ZONE , tag uuid , number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK9AFB1B71FE1E0397
                         FOREIGN KEY (customer_group) REFERENCES customer_group (id) ON
                         DELETE NO ACTION ON
                         UPDATE NO ACTION);


CREATE TABLE purchase (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , finished_time TIMESTAMP WITHOUT time ZONE , main_feature integer , net_total numeric , request_time TIMESTAMP WITHOUT time ZONE , STATE integer , tax numeric , token varchar(255), total numeric , client uuid NOT NULL, subscription uuid , "user" uuid , payment_type varchar(255), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FKB11644029734C7E6
                       FOREIGN KEY (client) REFERENCES client (id) ON
                       DELETE NO ACTION ON
                       UPDATE NO ACTION);


CREATE TABLE purchase_features (purchase uuid NOT NULL, features varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (purchase,features), CONSTRAINT FK865B33DA4F2C353
                                FOREIGN KEY (purchase) REFERENCES purchase (id) ON
                                DELETE NO ACTION ON
                                UPDATE NO ACTION);


CREATE TABLE purchase_unit_amounts (purchase uuid NOT NULL, unit_amounts integer , unit_amounts_key integer NOT NULL DEFAULT '0', PRIMARY KEY (purchase,unit_amounts_key), CONSTRAINT FKAA49B07D4F2C353
                                    FOREIGN KEY (purchase) REFERENCES purchase (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE promotion_position (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, receipt uuid , promotion uuid , redeemed bit(1) , GENERATED bit(1) , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT promotion_POSITION_RECEIPT
                              FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE receipt_discount_tax_payments (receipt uuid NOT NULL , discount_tax_payments uuid NOT NULL, PRIMARY KEY (receipt,discount_tax_payments), CONSTRAINT RECEIPT_DISCOUNT_TP_RECEIPTS
                                            FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                                            DELETE NO ACTION ON
                                            UPDATE NO ACTION);


CREATE TABLE receipt_info_texts (receipt uuid NOT NULL, info_texts varchar(255), info_texts_key integer NOT NULL DEFAULT '0', PRIMARY KEY (receipt,info_texts_key), CONSTRAINT FK77B869A94EB0B65B
                                 FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                                 DELETE NO ACTION ON
                                 UPDATE NO ACTION);


CREATE TABLE sales_tax (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, included bit(1) NOT NULL, name varchar(255), client uuid NOT NULL, economic_zone uuid , number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK854FF96BB1300747
                        FOREIGN KEY (economic_zone) REFERENCES economic_zone (id) ON
                        DELETE NO ACTION ON
                        UPDATE NO ACTION);


CREATE TABLE tax_payment (id uuid NOT NULL , amount numeric , current_tax_rate numeric , sales_tax uuid , PRIMARY KEY (id), CONSTRAINT TAX_PAYMENT_SALES_TAX
                          FOREIGN KEY (sales_tax) REFERENCES sales_tax (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE receipt_tax_payments (receipt uuid NOT NULL, tax_payments uuid NOT NULL , PRIMARY KEY (receipt,tax_payments), CONSTRAINT RECEIPT_TAX_PAYMENT
                                   FOREIGN KEY (tax_payments) REFERENCES tax_payment (id) ON
                                   DELETE NO ACTION ON
                                   UPDATE NO ACTION);


CREATE TABLE referral_partner_referrals (referral_partner uuid NOT NULL, referrals uuid NOT NULL, PRIMARY KEY (referral_partner,referrals), CONSTRAINT FKCBD700B4B102CC91
                                         FOREIGN KEY (referrals) REFERENCES client (id) ON
                                         DELETE NO ACTION ON
                                         UPDATE NO ACTION);


CREATE TABLE revenue_destination (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', default_value numeric NOT NULL DEFAULT '0.00', PRIMARY KEY (id), CONSTRAINT FKC317BED89734C7E6
                                  FOREIGN KEY (client) REFERENCES client (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE sale (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , base_item_price numeric , booking_time TIMESTAMP WITHOUT time ZONE , description varchar(255), gross_item_price numeric , item_number varchar(255), item_price numeric , manual_price bit(1) NOT NULL, net_item_price numeric , quantity decimal(18,3) , receipt_index integer NOT NULL, receipt_number varchar(255), client uuid NOT NULL, product uuid , cashier uuid , commodity_group uuid , item_sequence uuid , pos uuid , receipt uuid , sector uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', purchase_price decimal(17,4) NOT NULL DEFAULT '0.0000', cost decimal(17,4) NOT NULL DEFAULT '0.0000', set_type integer NOT NULL DEFAULT '0', receipt_indent integer NOT NULL DEFAULT '0', PRIMARY KEY (id), CONSTRAINT FKF9F9A47CE0FFA768
                   FOREIGN KEY (receipt) REFERENCES receipt (id) ON
                   DELETE NO ACTION ON
                   UPDATE NO ACTION);


CREATE TABLE sale_info_texts (sale uuid NOT NULL, info_texts varchar(255), info_texts_key integer NOT NULL DEFAULT '0', PRIMARY KEY (sale,info_texts_key), CONSTRAINT FKED03B9B8F5AA4213
                              FOREIGN KEY (sale) REFERENCES sale (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE sale_serial_numbers (sale uuid , serial_numbers varchar(255), CONSTRAINT SALE_SERIAL_NUMBERS
                                  FOREIGN KEY (sale) REFERENCES sale (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE sales_tax_rates (sales_tax uuid NOT NULL, percentage decimal(15,6) NOT NULL, valid_from TIMESTAMP WITHOUT time ZONE NOT NULL, PRIMARY KEY (sales_tax,percentage,valid_from), CONSTRAINT FKC27CAFBF668417BA
                              FOREIGN KEY (sales_tax) REFERENCES sales_tax (id) ON
                              DELETE NO ACTION ON
                              UPDATE NO ACTION);


CREATE TABLE tax_summary (id uuid NOT NULL , end_of_day_statement uuid NOT NULL, sales_tax uuid NOT NULL, net_amount numeric , tax_amount numeric , PRIMARY KEY (id), CONSTRAINT FK854FF96B9734C013
                          FOREIGN KEY (sales_tax) REFERENCES sales_tax (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE sale_tax_payments (sale uuid , id integer NOT NULL , tax_payments bigint , PRIMARY KEY (id), CONSTRAINT SALE_TAX_PAYMENT_SALE
                                FOREIGN KEY (sale) REFERENCES sale (id) ON
                                DELETE CASCADE ON
                                UPDATE NO ACTION);


CREATE TABLE sector (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK6400A8BD9734C7E6
                     FOREIGN KEY (client) REFERENCES client (id) ON
                     DELETE NO ACTION ON
                     UPDATE NO ACTION);


CREATE TABLE sector_revenue_shares (sector uuid NOT NULL, revenue_shares numeric , revenue_shares_key uuid NOT NULL, PRIMARY KEY (sector,revenue_shares_key), CONSTRAINT FKD18A61B9B3796939
                                    FOREIGN KEY (revenue_shares_key) REFERENCES revenue_destination (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE sector_tax_items (sector uuid NOT NULL, tax_index integer , tax uuid NOT NULL, PRIMARY KEY (sector,tax), CONSTRAINT FKCC1F92AE135DDFA
                               FOREIGN KEY (tax) REFERENCES sales_tax (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE send_report_task (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, origin_controlling varchar(255), send_report_task_type varchar(255)NOT NULL, dispatch_interval varchar(255)NOT NULL, interval_day_of_week integer NOT NULL DEFAULT '0', dispatch_time_of_day TIMESTAMP WITHOUT time ZONE , next_dispatch_time TIMESTAMP WITHOUT time ZONE NOT NULL, PRIMARY KEY (id));


CREATE TABLE send_report_task_parameter_map (send_report_task uuid NOT NULL , parameter_map varchar(255), parameter_map_key varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (send_report_task,parameter_map_key), CONSTRAINT SENDREPORTTASK_PARAMETERMAP_TASK
                                             FOREIGN KEY (send_report_task) REFERENCES send_report_task (id) ON
                                             DELETE NO ACTION ON
                                             UPDATE NO ACTION);


CREATE TABLE send_report_task_users (send_report_task uuid NOT NULL , users uuid NOT NULL , PRIMARY KEY (send_report_task,users), CONSTRAINT SENDREPORTTASK_USERS_USER
                                     FOREIGN KEY (users) REFERENCES "user" (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE stationery (id uuid NOT NULL, active bit(1) NOT NULL, pos_id uuid NOT NULL, revision bigint NOT NULL, client uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', TYPE varchar(255), DATA varchar(1024), organizational_unit uuid NOT NULL, thumbnail_id uuid , PRIMARY KEY (id), CONSTRAINT STATIONERY_ORGANIZATIONAL_UNIT
                         FOREIGN KEY (organizational_unit) REFERENCES organizational_unit (id) ON
                         DELETE NO ACTION ON
                         UPDATE NO ACTION);


CREATE TABLE stock_adjustment (id uuid NOT NULL, active bit(1) NOT NULL, pos_id uuid NOT NULL, revision bigint NOT NULL, client uuid NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', number varchar(255), number_value bigint DEFAULT '0', reason varchar(255), external_id varchar(255), finish_time TIMESTAMP WITHOUT time ZONE NOT NULL, booking_time TIMESTAMP WITHOUT time ZONE , warehouse uuid , positions integer DEFAULT '0', receipt_number varchar(255), PRIMARY KEY (id), CONSTRAINT STOCK_ADJUSTMENT_WAREHOUSE
                               FOREIGN KEY (warehouse) REFERENCES organizational_unit (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE stock_adjustment_item (id uuid NOT NULL, active bit(1) NOT NULL, pos_id uuid NOT NULL, revision bigint NOT NULL, origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', product uuid , stock_adjustment uuid , additional_goods numeric NOT NULL, client uuid NOT NULL, PRIMARY KEY (id), CONSTRAINT STOCK_ADJUSTMENT_ITEM_CLIENT
                                    FOREIGN KEY (client) REFERENCES client (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);


CREATE TABLE stock_order (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, target uuid , number varchar(255), create_time TIMESTAMP WITHOUT time ZONE NOT NULL, booking_time TIMESTAMP WITHOUT time ZONE , booked_by uuid , created_by uuid , SOURCE uuid , supplier uuid , currency varchar(3), pick_up_date TIMESTAMP WITHOUT time ZONE , required_from TIMESTAMP WITHOUT time ZONE , required_to TIMESTAMP WITHOUT time ZONE , special_offer_code varchar(255), buyer_information bigint , delivery_address_information bigint , final_recipient_information bigint , supplier_information bigint , transport_service_provider_information uuid , invoice_recipient_information bigint , description varchar(255), number_value bigint DEFAULT '0', auto_finalization TIMESTAMP WITHOUT time ZONE , pos_finalization_time TIMESTAMP WITHOUT time ZONE , dispatch_notification_creation_time TIMESTAMP WITHOUT time ZONE , stock_receipt_creation_time TIMESTAMP WITHOUT time ZONE , return_creation_time TIMESTAMP WITHOUT time ZONE , stock_receipt_finalization_time TIMESTAMP WITHOUT time ZONE , auto_send bit(1) NOT NULL DEFAULT b'0', send bit(1) NOT NULL DEFAULT b'0', customer uuid , pos uuid , deposit numeric , positions integer DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_TRANSPORT_SERVICE_PROVIDER_INFORMATION
                          FOREIGN KEY (transport_service_provider_information) REFERENCES address_information (id) ON
                          DELETE NO ACTION ON
                          UPDATE NO ACTION);


CREATE TABLE stock_order_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, quantity numeric , purchase_price decimal(19,4) , sales_price numeric , product uuid , order_id uuid , supplier_item_number varchar(255), product_number varchar(255), name varchar(255), color varchar(255), SIZE varchar(255), code varchar(255), desired_overall_quantity numeric , actual_overall_quantity numeric , container_quantity numeric , item_price decimal(17,4) , booked_quantity numeric , delivery_date TIMESTAMP WITHOUT time ZONE , received_quantity numeric DEFAULT '0.00', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', item_index integer , PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_ITEM_ORDER_ID
                               FOREIGN KEY (order_id) REFERENCES stock_order (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE stock_order_request (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255), number_value bigint DEFAULT '0', create_time TIMESTAMP WITHOUT time ZONE NOT NULL, customer varchar(255), customer_phone varchar(255), deposit numeric , finish_time TIMESTAMP WITHOUT time ZONE , pick_up_date TIMESTAMP WITHOUT time ZONE , pos uuid , positions integer DEFAULT '0', target uuid , assigned bit(1) NOT NULL DEFAULT b'0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_REQUEST_TARGET
                                  FOREIGN KEY (target) REFERENCES organizational_unit (id) ON
                                  DELETE NO ACTION ON
                                  UPDATE NO ACTION);


CREATE TABLE stock_order_request_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, order_request uuid NOT NULL, product uuid NOT NULL, quantity numeric NOT NULL, supplier uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_REQUEST_ITEM_SUPPLIER
                                       FOREIGN KEY (supplier) REFERENCES supplier (id) ON
                                       DELETE NO ACTION ON
                                       UPDATE NO ACTION);


CREATE TABLE stock_order_template (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, number varchar(255)NOT NULL, number_value bigint DEFAULT '0', name varchar(255), target uuid , SOURCE uuid , supplier uuid , load_short_stocks bit(1) DEFAULT b'0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_TEMPLATE_CLIENT
                                   FOREIGN KEY (client) REFERENCES client (id) ON
                                   DELETE NO ACTION ON
                                   UPDATE NO ACTION);


CREATE TABLE stock_order_template_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, quantity numeric , product uuid , order_id uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', item_type varchar(255), commodity_group uuid , PRIMARY KEY (id), CONSTRAINT STOCK_ORDER_TEMPLATE_ITEM_COMMODITY_GROUP
                                        FOREIGN KEY (commodity_group) REFERENCES commodity_group (id) ON
                                        DELETE NO ACTION ON
                                        UPDATE NO ACTION);


CREATE TABLE stock (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , goods numeric , ordered_goods numeric , reorder_level numeric , client uuid NOT NULL, product uuid , warehouse uuid , max_level numeric , last_stock_decrease_time TIMESTAMP WITHOUT time ZONE , last_stock_increase_time TIMESTAMP WITHOUT time ZONE , last_stock_request_time TIMESTAMP WITHOUT time ZONE , last_stock_order_time TIMESTAMP WITHOUT time ZONE , last_inventory_time TIMESTAMP WITHOUT time ZONE , last_inventory_list_add_time TIMESTAMP WITHOUT time ZONE , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', average_purchase_price decimal(13,8) NOT NULL DEFAULT '0.00000000', PRIMARY KEY (id), CONSTRAINT STOCK_WAREHOUSE
                    FOREIGN KEY (warehouse) REFERENCES organizational_unit (id) ON
                    DELETE NO ACTION ON
                    UPDATE NO ACTION);


CREATE TABLE stock_receipt (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, pos uuid , cashier uuid , target uuid , arrival TIMESTAMP WITHOUT time ZONE , order_number varchar(255), number varchar(255), booked_by uuid , booking_time TIMESTAMP WITHOUT time ZONE , description varchar(255), supplier uuid , SOURCE uuid , create_time TIMESTAMP WITHOUT time ZONE NOT NULL, created_by uuid , buyer_information bigint , delivery_address_information bigint , final_recipient_information bigint , supplier_information bigint , transport_service_provider_information uuid , invoice_recipient_information bigint , transport_document_type varchar(255), transport_document_number varchar(255), dispatch_notification uuid , order_id uuid , number_value bigint DEFAULT '0', customer uuid , positions integer DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_RECEIPT_TRANSPORT_SERVICE_PROVIDER_INFORMATION
                            FOREIGN KEY (transport_service_provider_information) REFERENCES address_information (id) ON
                            DELETE NO ACTION ON
                            UPDATE NO ACTION);


CREATE TABLE stock_receipt_item (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, received_goods numeric , product uuid , receipt uuid , supplier_item_number varchar(255), buyer_item_number varchar(255), name varchar(255), color varchar(255), SIZE varchar(255), code varchar(255), expected_goods numeric DEFAULT '0.00', item_price decimal(16,5) DEFAULT '0.00000', clear_ordered_goods bit(1) NOT NULL DEFAULT b'0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT STOCK_RECEIPT_ITEM_RECEIPT
                                 FOREIGN KEY (receipt) REFERENCES stock_receipt (id) ON
                                 DELETE NO ACTION ON
                                 UPDATE NO ACTION);


CREATE TABLE stock_snapshot (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , goods numeric , ordered_goods numeric , reorder_level numeric , client uuid NOT NULL, product uuid , warehouse uuid , valid_from TIMESTAMP WITHOUT time ZONE , valid_to TIMESTAMP WITHOUT time ZONE , max_level numeric , last_stock_decrease_time TIMESTAMP WITHOUT time ZONE , last_stock_increase_time TIMESTAMP WITHOUT time ZONE , last_stock_request_time TIMESTAMP WITHOUT time ZONE , last_stock_order_time TIMESTAMP WITHOUT time ZONE , last_inventory_time TIMESTAMP WITHOUT time ZONE , last_inventory_list_add_time TIMESTAMP WITHOUT time ZONE , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', average_purchase_price decimal(13,8) NOT NULL DEFAULT '0.00000000', PRIMARY KEY (id), CONSTRAINT STOCK_SNAPSHOT_WAREHOUSE
                             FOREIGN KEY (warehouse) REFERENCES organizational_unit (id) ON
                             DELETE NO ACTION ON
                             UPDATE NO ACTION);


CREATE TABLE subscription (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , "end" TIMESTAMP WITHOUT time ZONE , main_feature varchar(255), START TIMESTAMP WITHOUT time ZONE , subscription_length varchar(255), client uuid NOT NULL, paypal_profile_id varchar(255), last_pay_reminder TIMESTAMP WITHOUT time ZONE , COMMENT varchar(512), origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', package_id integer DEFAULT '0', enabled bit(1) NOT NULL, modification_restriction TIMESTAMP WITHOUT time ZONE , next_invoice TIMESTAMP WITHOUT time ZONE , PRIMARY KEY (id), CONSTRAINT FK47A521669734C7E6
                           FOREIGN KEY (client) REFERENCES client (id) ON
                           DELETE NO ACTION ON
                           UPDATE NO ACTION);


CREATE TABLE subscription_additions (subscription uuid NOT NULL, additions varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (subscription,additions), CONSTRAINT FK5863B95EB65810D3
                                     FOREIGN KEY (subscription) REFERENCES subscription (id) ON
                                     DELETE NO ACTION ON
                                     UPDATE NO ACTION);


CREATE TABLE subscription_unit_amounts (subscription uuid NOT NULL, unit_amounts integer , unit_amounts_key integer NOT NULL DEFAULT '0', PRIMARY KEY (subscription,unit_amounts_key), CONSTRAINT FK5C2CB599B65810D3
                                        FOREIGN KEY (subscription) REFERENCES subscription (id) ON
                                        DELETE NO ACTION ON
                                        UPDATE NO ACTION);


CREATE TABLE "table" (id uuid NOT NULL,
                              active bit(1) NOT NULL,
                                            table_column integer , direction varchar(255),
                                                                             name varchar(255),
                                                                                  table_row integer , x integer NOT NULL,
                                                                                                                y integer NOT NULL,
                                                                                                                          TYPE varchar(255),
                                                                                                                               PRIMARY KEY (id));


CREATE TABLE ticket_validity_description (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, daily_valid_from TIMESTAMP WITHOUT time ZONE , daily_valid_until TIMESTAMP WITHOUT time ZONE , max_possible_admissions integer , max_possible_admissions_per_day integer , name varchar(255), valid_from_fixed TIMESTAMP WITHOUT time ZONE , valid_to_fixed TIMESTAMP WITHOUT time ZONE , client uuid NOT NULL, activation_delay_str varchar(255), validity_period_after_entrance_str varchar(255), validity_period_after_purchase_str varchar(255), number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK74876BE19734C7E6
                                          FOREIGN KEY (client) REFERENCES client (id) ON
                                          DELETE NO ACTION ON
                                          UPDATE NO ACTION);


CREATE TABLE ticket_validity_description_entry_gates (ticket_validity_description uuid NOT NULL, entry_gates uuid NOT NULL, PRIMARY KEY (ticket_validity_description,entry_gates), CONSTRAINT FKF1AD1B9DC99B3997
                                                      FOREIGN KEY (ticket_validity_description) REFERENCES ticket_validity_description (id) ON
                                                      DELETE NO ACTION ON
                                                      UPDATE NO ACTION);


CREATE TABLE time_tracking_entity (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, name varchar(255), paid_time bit(1) , number varchar(255)NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT TIME_TRACKING_ENTITY_CLIENT
                                   FOREIGN KEY (client) REFERENCES client (id) ON
                                   DELETE NO ACTION ON
                                   UPDATE NO ACTION);


CREATE TABLE time_tracking_period_entry (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , client uuid NOT NULL, time_tracking_entity uuid , cashier uuid , START TIMESTAMP WITHOUT time ZONE , organizational_unit uuid , origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK_TIME_TRACKING_PERIOD_ENTRY_ORG
                                         FOREIGN KEY (organizational_unit) REFERENCES organizational_unit (id) ON
                                         DELETE CASCADE);


CREATE TABLE user_login_tickets ("user" uuid NOT NULL, login_tickets uuid NOT NULL, PRIMARY KEY ("user",login_tickets), CONSTRAINT USER_LOGINTICKET_USER
                                 FOREIGN KEY ("user") REFERENCES "user" (id) ON
                                 DELETE CASCADE ON
                                 UPDATE CASCADE);


CREATE TABLE user_orgs ("user" uuid NOT NULL, orgs uuid NOT NULL, PRIMARY KEY ("user",orgs), CONSTRAINT FKBD0FB18BD63C472B
                        FOREIGN KEY (orgs) REFERENCES organizational_unit (id) ON
                        DELETE NO ACTION ON
                        UPDATE NO ACTION);


CREATE TABLE user_permissions ("user" uuid NOT NULL, permissions varchar(255)NOT NULL DEFAULT '', PRIMARY KEY ("user",permissions), CONSTRAINT FK20ECEA3D8CA37293
                               FOREIGN KEY ("user") REFERENCES "user" (id) ON
                               DELETE NO ACTION ON
                               UPDATE NO ACTION);


CREATE TABLE user_role (id uuid NOT NULL, active bit(1) NOT NULL, revision bigint , number varchar(255)NOT NULL, name varchar(255), client uuid NOT NULL, number_value bigint DEFAULT '0', origin_controlling varchar(255)NOT NULL DEFAULT 'NONE', PRIMARY KEY (id), CONSTRAINT FK143B0B789734C7E7
                        FOREIGN KEY (client) REFERENCES client (id) ON
                        DELETE NO ACTION ON
                        UPDATE NO ACTION);


CREATE TABLE user_role_permissions (user_role uuid NOT NULL, permissions varchar(255)NOT NULL DEFAULT '', PRIMARY KEY (user_role,permissions), CONSTRAINT FK20ECEA3D8CA37294
                                    FOREIGN KEY (user_role) REFERENCES user_role (id) ON
                                    DELETE NO ACTION ON
                                    UPDATE NO ACTION);