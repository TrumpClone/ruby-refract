# ruby-refract

Implemenation of recursive search inside JSON structures according to refract document format specification.

## Usage

```
require 'ruby-refract'

api_object = { "element"=>"parseResult", "content" => [{"element"=>"category", "meta"=>{"classes"=>["api"], "title"=>{"element"=>"string", "content"=>"The Simplest API"}}}]}

Refract.search(api_object, { 'element' => 'category' })
```

### Get all resource groups

```
Refract.search(api_object, {
  "element" => "category",
  "meta" => {
    "classes" => [
      "resourceGroup",
    ],
  }
})
```
