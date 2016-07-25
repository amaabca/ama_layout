describe AmaLayout::BreadcrumbBuilder do
  let(:view_context) { ActionView::Base.new }

  describe '#render' do
    let(:builder) { AmaLayout::BreadcrumbBuilder.new(view_context, crumbs) }

    context 'no separator specified' do
      let(:crumbs) do
        [
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Foo', '/foo'),
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Bar', '/foo/bar')
        ]
      end

      it 'returns the breadcrumb HTML without any separator' do
        expect(builder.render).to eq('<li><a href="/foo">Foo</a></li><li><a href="/foo/bar">Bar</a></li>')
      end
    end

    context 'with a separator of " > "' do
      let(:builder) { AmaLayout::BreadcrumbBuilder.new(view_context, crumbs, separator: ' > ') }
      let(:crumbs) do
        [
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Foo', '/foo'),
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Bar', '/foo/bar')
        ]
      end

      it 'returns the breadcrumb HTML with the proper separator' do
        expect(builder.render).to eq('<li><a href="/foo">Foo</a></li> > <li><a href="/foo/bar">Bar</a></li>')
      end
    end

    context 'with a disabled element' do
      let(:crumbs) do
        [
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Foo', '/foo'),
          BreadcrumbsOnRails::Breadcrumbs::Element.new('Bar', '/foo/bar', disabled: true)
        ]
      end

      it 'adds the appropriate disabled attributes to the element' do
        expect(builder.render).to match /breadcrumbs__link--disabled/
      end
    end
  end
end
