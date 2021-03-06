/*******************************************************************************
 * Copyright (C) 2011 Atlas of Living Australia
 * All Rights Reserved.
 * 
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ******************************************************************************/
package au.org.ala.delta.key.directives;

import java.io.File;

import au.org.ala.delta.directives.DirectiveParserObserver;
import au.org.ala.delta.key.KeyContext;

public class KeyInputFileDirective extends AbstractKeyInputFileDirective {
    
    public KeyInputFileDirective() {
        super("input", "file");
    }

    @Override
    void parseFile(File file, KeyContext context) throws Exception {
        KeyDirectiveParser parser = KeyDirectiveParser.createInstance();
        DirectiveParserObserver observer = context.getDirectiveParserObserver();
        if (observer != null) {
            parser.registerObserver(observer);
        }
        parser.parse(file, context);  
    }

}
