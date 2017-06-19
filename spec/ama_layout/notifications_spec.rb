describe AmaLayout::Notifications do
  let(:redis) do
    AmaLayout::Notifications::RedisStore.new(
      db: 4,
      namespace: 'test_notifications',
      host: 'localhost'
    )
  end
  let(:json) do
    <<-JSON
    {
      "02ac263cea5660e9f9020cb46e93772ed7755f2a60c40ad8961d2a15c1f99e6f": {
      "type": "notice",
      "header": "test",
      "content": "test",
      "created_at": "2017-06-19T11:26:57.730-06:00",
      "active": true,
      "version": "1.0.0"
      }
    }
    JSON
  end

  around(:each) do |example|
    redis.clear
    example.run
    redis.clear
  end

  context 'when including module' do
    let(:klass) { Class.new.include(described_class) }

    context 'class methods' do
      before(:each) do
        klass.class_eval do
          notification_store AmaLayout::Notifications::RedisStore.new(
            db: 4,
            namespace: 'test_notifications',
            host: 'localhost'
          )
          notification_foreign_key :my_id

          def my_id
            @id ||= SecureRandom.uuid
          end
        end
      end

      describe '#_notification_foreign_key' do
        it 'returns the id method as a proc' do
          expect(klass._notification_foreign_key).to be_a(Proc)
        end
      end

      describe '#_notification_store' do
        it 'returns the set data store' do
          expect(klass._notification_store).to be_an(AmaLayout::Notifications::RedisStore)
        end
      end
    end

    context 'instance methods' do
      context 'with a valid notification store' do
        subject { klass.new }

        before(:each) do
          klass.class_eval do
            notification_store AmaLayout::Notifications::RedisStore.new(
              db: 4,
              namespace: 'test_notifications',
              host: 'localhost'
            )
            notification_foreign_key :my_id

            def my_id
              @id ||= SecureRandom.uuid
            end
          end
        end

        describe '#notifications' do
          before(:each) do
            redis.set("users/#{subject.my_id}", json)
          end

          it 'fetches notifications from redis' do
            expect(subject.notifications.size).to eq(1)
          end
        end

        describe '#notifications=' do
          it 'resets the notifications to nil' do
            subject.notifications = nil
            expect(subject.notifications).to be_empty
          end
        end
      end

      context 'with an undefined notification store' do
        it 'raises InvalidNotificationStore' do
          expect { klass.new.notifications }.to raise_error(AmaLayout::Notifications::InvalidNotificationStore)
        end
      end
    end
  end
end
