# Do not include default locale in generated URLs
RoutingFilter::Locale.include_default_locale = false

# Then if the default locale is :es
# products_path(:locale => 'es') => /products
# products_path(:locale => 'en') => /en/products