<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  
  <title>Style2Tag Map Schematron</title>
  
  <ns uri="urn:public:dita4publishers.org:namespaces:word2dita:style2tagmap" prefix="s2t"/>
  
  <pattern id="s2t.format.output">
    <title>Does @format on mapProperties or topicProperties match an output elem's @name?</title>
    <rule context="s2t:mapProperties[@format]|s2t:topicProperties[@format]">    
      <let name="format" value="@format" />            
      <let name="output" value="//s2t:output[@name = $format]"/>                                 
      <report test="not($output)">
        <value-of select="name()"/> @format attribute [<value-of select="$format"/>] does not match 
        an existing output element's @name
      </report>
    </rule>    
  </pattern>
  
  <pattern id="s2t.topicDoc.has.format"> 
    <title>Does topicProperties element with @topicDoc='yes' have @format?</title>
    <rule context="s2t:topicProperties[@topicDoc='yes']">                                            
      <assert test="@format">
        <value-of select="name()"/> @format attribute is missing; it should be present because
        @topicDoc is yes.
      </assert>
    </rule>    
  </pattern>
  
  <pattern id="s2t.containingTopic.is.root.obsolete">
    <title>Does @containingTopic = root (which is obsolete value)?</title>
    <rule context="s2t:paragraphStyle[@containingTopic='root']">                                            
      <report test="true()">
        <value-of select="name()"/> @containingTopic is 'root', which is obsolete. Use 'roottopic'.
      </report>
    </rule>    
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.prologType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @prologType?</title>
    <param name="attribute" value="@prologType"/>
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.shortdescType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @shortdescType?</title>
    <param name="attribute" value="@shortdescType"/>
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.bodyType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @bodyType?</title>
    <param name="attribute" value="@bodyType"/>
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.abstractType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @abstractType?</title>
    <param name="attribute" value="@abstractType"/>
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.topicType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @topicType?</title>
    <param name="attribute" value="@topicType"/>
  </pattern>
  
  <pattern id="s2t.topicProperties.precedence.over.output.initialSectionType" is-a="s2t.topicProperties.precedence.over.output">
    <title>Does topicProperties and output have differing @initialSectionType?</title>
    <param name="attribute" value="@initialSectionType"/>
  </pattern>
  
  <pattern abstract="true" id="s2t.topicProperties.precedence.over.output">
    <title>Abstract pattern for checking whether topicProperties has different attribute values
    than corresponding output element.</title>
    <rule context="s2t:topicProperties[$attribute]">
      <let name="curValue" value="$attribute"/>
      <let name="format" value="@format" />            
      <let name="output" value="//s2t:output[@name = $format]"/>
      <report test="$output/$attribute[. ne $curValue]" role="warning"> <!-- would prefer to do
        information for @role but that does not provide any indicator within oXygen that there is a
        message -->
        <value-of select="local-name()"/> @<value-of select="name($attribute)"/> with value 
        [<value-of select="$attribute"/>] that takes precedence over the output element's attribute 
        @<value-of select="name($attribute)"/>.
      </report>
    </rule>
  </pattern>
 
  <pattern id="s2t.style.elem.deprecated">
    <title>Is the style element, which is deprecated, used?</title>
    <rule context="s2t:style">
      <report test="self::s2t:style" role="warning">
        The style element is deprecated. Migrate to paragraphStyle or characterStyle.
      </report>
    </rule>
  </pattern>
  
  <pattern id="s2t.styleName.takes.precedence.over.styleId">
    <title>Does a style definition have a styleName and a styleId attribute?</title>
    <rule context="s2t:paragraphStyle|s2t:characterStyle|s2t:style">
      <report test="@styleName = @styleId" role="warning">
        <value-of select="name()"/> has @styleName and @styleId. @styleName takes precedence.
      </report>
    </rule>
  </pattern>
  
  
  <pattern id="s2t.check.data">
    <title>Does data elem miss some attributes that we want to warn about?</title>
    <rule context="s2t:paragraphStyle[@tagName='data' or @baseClass=' topic/data ']">
      <report test="not(@putValueIn)" role="warning">
        <value-of select="name()"/> is missing @putValueIn attribute but maps to data; should specify
        either "content" or "value".
      </report>
      <report test="not(@dataName)" role="warning">
        <value-of select="name()"/> does not specify @dataName, which is generally only desirable when
        the element type has a default value for the data's @name.
      </report>
    </rule>
  </pattern>
</schema>