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
package au.org.ala.delta.ui.rtf;

import java.awt.event.KeyEvent;

public class AcuteCharacterHandler extends SpecialCharHandler {
	
	@SuppressWarnings("unchecked")
	public AcuteCharacterHandler() {
		super(KeyEvent.VK_QUOTE, KeyEvent.CTRL_MASK, SpecialCharacterMode.AcuteAccents, 0x2032,
			pair('a', 0xe1),				
		    pair('A', 0xc1),
		    pair('e', 0xe9),
		    pair('E', 0xc9),
		    pair('i', 0xed),
		    pair('I', 0xcd),
		    pair('o', 0xf3),
		    pair('O', 0xd3),
		    pair('u', 0xfa),
		    pair('U', 0xda),
		    pair('y', 0xfd),
		    pair('Y', 0xdd),
		    pair('c', 0x107),
		    pair('C', 0x106),
		    pair('d', 0xf0),
		    pair('D', 0xd0),
		    pair('l', 0x13a),
		    pair('L', 0x139),
		    pair('n', 0x144),
		    pair('N', 0x143),
		    pair('r', 0x155),
		    pair('R', 0x154),
		    pair('s', 0x15b),
		    pair('S', 0x15a),
		    pair('t', 0x163),
		    pair('T', 0x162),
		    pair('z', 0x17a),
		    pair('Z', 0x179),
		    pair('\'', 146),
		    pair('\"', 148)				
		);
	}
	
}
